import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toy_trader/models/Conversation.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toy_trader/models/TextMessage.dart';
import '../../../models/Toy.dart';
import '../models/ImageMessage.dart';
import '../models/Message.dart';
import '../models/Trade.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  List<Toy> toyList = [];

  Toy toy1 = Toy('0', '0', 'car',"this is discription", 'condition of toy','10-11','categories',"imageurl");
  Toy toy2 = Toy('1', '1', 'Boat',"this is discription", 'condition of toy','10-11','categories',"imageurl");


  factory DatabaseService(){
    return _instance;
  }

  //Initialization of the Instance of the class
  DatabaseService._internal(){
    toyList.add(toy1);
    toyList.add(toy2);
  }

  Future setProfileInfo(ProfileInfo profileInfo, File? imageFile) async {

    if(imageFile != null) {
      final storage = FirebaseStorage.instance.ref('users').child(
          profileInfo.uid).child('profileImage');
      await storage.putFile(imageFile);
      final profileImgUrl = (await storage.getDownloadURL()).toString();
      profileInfo.profileImageUrl = profileImgUrl;
    }

    return await FirebaseFirestore.instance.collection('users').doc(profileInfo.uid).set(
      profileInfo.toJson()
    );
  }

  Future<List<Toy>> getUserToys(String userId) async {
    if (userId.isEmpty) {
      var user = FirebaseAuth.instance.currentUser?.uid;
      var query = await FirebaseFirestore.instance.collection('users')
          .where('uid', isEqualTo: user).get();
      var userData = query.docs.map((doc) => doc).toList();

      var toys = <Toy>[];
      for (var item in userData[0].get("toys")) {
        var _toy = Toy(
            item["toyId"],
            item["ownerId"],
            item["name"],
            item["description"],
            item["condition"],
            item["ageRange"],
            item["categories"],
            item["toyImageURL"]);
        toys.add(_toy);
      }
      return toys;
    }

    else {
      var query = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: userId).get();
      var userData = query.docs.map((doc) => doc).toList();
      var toys = <Toy> [];

      for(var item in userData[0].get("toys")){
        var _toy = Toy(item["toyId"], item["ownerId"], item["name"], item["description"], item["condition"], item["ageRange"], item["categories"], item["toyImageURL"]);
        toys.add(_toy);
      }

      return toys;
    }
  }

  Future<ProfileInfo> getProfileInfo(String userId) async {
    if (userId.isEmpty) {
      var user = FirebaseAuth.instance.currentUser?.uid;
      var query = await FirebaseFirestore.instance.collection('users')
          .where('uid', isEqualTo: user).get();
      var userData = query.docs.map((doc) => doc).toList();

      var toys = <Toy>[];
      for(var item in userData[0].get("toys")){
        var _toy = Toy(item["toyId"], item["ownerId"], item["name"], item["description"], item["condition"], item["ageRange"], item["categories"], item["toyImageURL"]);
        toys.add(_toy);
      }


      final profileInfo = ProfileInfo(uid: userData[0].id,
          screenName: userData[0].get("screenName"),
          ageRange: userData[0].get("ageRange"),
          interests: userData[0].get("interests"),
          toys: toys,
          profileImageUrl: userData[0].get("profileImageUrl"),
          userRating: userData[0].get("userRating"),
          totalRates: userData[0].get("totalRates")
      );

      return profileInfo;
    }

    var query = await FirebaseFirestore.instance.collection('users')
        .where('uid', isEqualTo: userId).get();
    var userData = query.docs.map((doc) => doc).toList();

    var toys = <Toy>[];
    for(var item in userData[0].get("toys")){
      var _toy = Toy(item["toyId"], item["ownerId"], item["name"], item["description"], item["condition"], item["ageRange"], item["categories"], item["toyImageURL"]);
      toys.add(_toy);
    }
    final profileInfo = ProfileInfo(uid: userData[0].id,
        screenName: userData[0].get("screenName"),
        ageRange: userData[0].get("ageRange"),
        interests: userData[0].get("interests"),
        toys: toys,
        profileImageUrl: userData[0].get("profileImageUrl"),
        userRating: userData[0].get("userRating"),
        totalRates: userData[0].get("totalRates")
    );

    return profileInfo;
  }


  Future<List<Conversation>> getConversations(String userId) async {

    print("getting conversations");

    var query = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("conversations")
        .get();

    var conversations = query.docs.map((doc) => Conversation.fromJson(doc.data())).toList();

    for(var c in conversations){
      print(c.lastMessage);
    }

    return conversations;
  }

  Future<List<Toy>> getMainFeed(String searchText) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    var user = FirebaseAuth.instance.currentUser?.uid;
    var profiles = querySnapshot.docs.map((doc) => doc).toList();

    List<ProfileInfo> profileList = [];

    profiles.removeWhere((element) => element.get("uid") == user);
    for (var i = 0; i < profiles.length; i++) {
      List<Toy> toyList = [];

      for (var item in profiles[i].get("toys")) {
        var _toy = Toy(item["toyId"], item["ownerId"], item["name"], item["description"], item["condition"], item["ageRange"], item["categories"], item["toyImageURL"]);
        toyList.add(_toy);
      }

      profileList.add(ProfileInfo(
          uid: profiles[i].get("uid"),
          screenName: profiles[i].get("screenName"),
          ageRange: profiles[i].get("ageRange"),
          interests: profiles[i].get("interests"),
          toys: toyList,
          profileImageUrl: profiles[i].get("profileImageUrl"),
          userRating: profiles[0].get("userRating"),
          totalRates: profiles[0].get("totalRates")),
      );
    }

    List<Toy> toyList = [];
    for (var i = 0; i < profileList.length; i++) {
      for (var item in profileList[i].toys) {
        toyList.add(item);
      }
    }

    toyList.shuffle();

    if (searchText.isEmpty) {
      return toyList;
    }

    else {
      List<Toy> newToyList = [];
      for (var i = 0; i < toyList.length; i++) {
        String toyString = toyList[i].name.toLowerCase();
        if (toyString.contains(searchText.toLowerCase())) {
          newToyList.add(toyList[i]);
        }
      }
      return newToyList;
    }
  }

  Future<bool> addToyData(Toy toy, ProfileInfo profileInfo, File toyImage,) async {
    final storage = FirebaseStorage.instance.ref('users').child(
        profileInfo.uid).child('toys').child(toy.toyId);
    await storage.putFile(toyImage);
    final toyImgURL = (await storage.getDownloadURL()).toString();
    toy.toyImageURL = toyImgURL;

    profileInfo.toys.add(toy);
    try {
      await setProfileInfo(profileInfo, null);
      return true;
    }
    on Exception catch(_) {
      return false;
    }
  }

  getToyList(){
    return toyList;
  }


  Future deleteToy(Toy toy) async{
    try{

      var profileInfo = await getProfileInfo(FirebaseAuth.instance.currentUser!.uid);

      // delete toy image from firebase storage
      await FirebaseFirestore.instance.collection('users')
          .doc(profileInfo.uid).collection('toys')
          .doc(toy.toyId).delete();

      // delete toy from user's profileInfo
      int len = profileInfo.toys.length;

      print(profileInfo.toys);
      for(var i =0; i < len-1;i++){
        if(toy.toyId == profileInfo.toys[i].toyId){
          profileInfo.toys.removeAt(i);
          print("we found a match");
          break;
        }
      }
      print(profileInfo.toys);


      setProfileInfo(profileInfo, null);

    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<bool> sendTextMessage(TextMessage textMessage) async {
    try{
      var senderProfileInfo = await getProfileInfo(textMessage.senderId);
      var receiverProfileInfo = await getProfileInfo(textMessage.receiverId);

      var conversation = Conversation(receiverProfileInfo.uid, receiverProfileInfo.screenName, receiverProfileInfo.profileImageUrl, textMessage.message, textMessage.time);
      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.senderId).collection('conversations').doc(textMessage.receiverId).set(conversation.toJson());

      conversation = Conversation(senderProfileInfo.uid, senderProfileInfo.screenName, senderProfileInfo.profileImageUrl, textMessage.message, textMessage.time);
      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.receiverId).collection('conversations').doc(textMessage.senderId).set(conversation.toJson());

      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.senderId).collection('conversations').doc(textMessage.receiverId).collection('messages').doc(textMessage.messageId).set(textMessage.toJson());

      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.receiverId).collection('conversations').doc(textMessage.senderId).collection('messages').doc(textMessage.messageId).set(textMessage.toJson());

      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<bool> sendImageMessage(ImageMessage imageMessage, File img) async{
    try{

      var senderProfileInfo = await getProfileInfo(imageMessage.senderId);
      var receiverProfileInfo = await getProfileInfo(imageMessage.receiverId);

      //****************** sender ***********************

      // upload image to storage
      var storage = FirebaseStorage.instance.ref('users').child(imageMessage.senderId)
          .child('conversations').child(imageMessage.receiverId).child('messages')
          .child(imageMessage.messageId);
      await storage.putFile(img);

      //get and set download url
      var imgURL = (await storage.getDownloadURL()).toString();
      imageMessage.imageUrl = imgURL;

      // upload conversation to Firestore
      var conversation = Conversation(receiverProfileInfo.uid, receiverProfileInfo.screenName, receiverProfileInfo.profileImageUrl, 'Image', imageMessage.time);
      await FirebaseFirestore.instance.collection('users')
          .doc(imageMessage.senderId).collection('conversations')
          .doc(imageMessage.receiverId).set(conversation.toJson());

      // upload message to Firestore
      await FirebaseFirestore.instance.collection('users')
          .doc(imageMessage.senderId).collection('conversations')
          .doc(imageMessage.receiverId).collection('messages')
          .doc(imageMessage.messageId).set(imageMessage.toJson());


      //****************** receiver ***********************

      // upload image to storage for message sender
      storage = FirebaseStorage.instance.ref('users').child(imageMessage.receiverId)
          .child('conversations').child(imageMessage.senderId).child('messages')
          .child(imageMessage.messageId);
      await storage.putFile(img);
      //get and set download url
      imgURL = (await storage.getDownloadURL()).toString();
      imageMessage.imageUrl = imgURL;


      // upload conversation to Firestore for message sender
      conversation = Conversation(senderProfileInfo.uid, senderProfileInfo.screenName, senderProfileInfo.profileImageUrl, 'Image', imageMessage.time);
      await FirebaseFirestore.instance.collection('users')
          .doc(imageMessage.receiverId).collection('conversations')
          .doc(imageMessage.senderId).set(conversation.toJson());

      // upload message to Firestore for message sender
      await FirebaseFirestore.instance.collection('users')
          .doc(imageMessage.receiverId).collection('conversations')
          .doc(imageMessage.senderId).collection('messages')
          .doc(imageMessage.receiverId).set(imageMessage.toJson());

      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }



  Future<List<Message>> getMessages(String userId, String otherUserId) async {
    var result = await FirebaseFirestore.instance.collection('users').doc(userId).collection('conversations')
        .doc(otherUserId).collection('messages').get();
    List<Message> messages = [];

    for(int i = 0; i < result.docs.length; i++){
      if(result.docs[i].get("type") == "TEXT") {
        var message = TextMessage.fromJson(result.docs[i].data());
        messages.add(message);
        print(message.message);
      }


      else if(result.docs[i].get("type") == "IMAGE") {
        var message = ImageMessage.fromJson(result.docs[i].data());
        messages.add(message);
      }
    }

    return messages;
  }

  Future<bool> sendTradeOffer(Trade trade) async {
    try {

      // add trade to database under trade sender
      await FirebaseFirestore.instance.collection('users').doc(trade.senderId)
          .collection('trades').doc(trade.tradeId).set(trade.toJson());

      // add trade to database under trade receiver
      await FirebaseFirestore.instance.collection('users').doc(trade.senderId)
          .collection('trades').doc(trade.tradeId).set(trade.toJson());
      return true;
    } catch (e){
      print(e.toString());
      return false;
    }
  }

  Future<List<Trade>>getTrades() async {
    var result = await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).collection('trades').get();
    var trades = result.docs.map((doc) => Trade.fromJson(doc.data())).toList();
    return trades;
  }

  Future<bool> rateUser(double rating, String otherUserId) async{
    try{
      var otherUserProfile = await getProfileInfo(otherUserId);
      otherUserProfile.userRating = otherUserProfile.userRating + rating;
      otherUserProfile.totalRates += 1;
      await setProfileInfo(otherUserProfile, null);
      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
}

