import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toy_trader/models/Conversation.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toy_trader/models/TextMessage.dart';
import '../../../models/Toy.dart';
import 'package:uuid/uuid.dart';


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

  Future setProfileInfo(Map<String,dynamic> profileInfo, File? imageFile) async {

    if(imageFile != null) {
      final storage = FirebaseStorage.instance.ref('users').child(
          profileInfo['uid']).child('profileImage');
      await storage.putFile(imageFile);
      final profileImgUrl = (await storage.getDownloadURL()).toString();
      profileInfo['profileImageUrl'] = profileImgUrl;
    }

    return await FirebaseFirestore.instance.collection('users').doc(profileInfo['uid']).set({
      'uid': profileInfo['uid'],
      'screenName': profileInfo['screenName'],
      'ageRange': profileInfo['ageRange'],
      'interests': profileInfo['interests'],
      'toys': profileInfo['toys'],
      'profileImageUrl': profileInfo['profileImageUrl']
    });
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
          profileImageUrl: userData[0].get("profileImageUrl"));

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
        profileImageUrl: userData[0].get("profileImageUrl"));

    return profileInfo;
  }

  Future<List<Toy>> getMainFeed() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    final profileInfoList = querySnapshot.docs.map((doc) => ProfileInfo(
        uid: doc.id,
        screenName: doc.get("screenName"),
        ageRange: doc.get("ageRange"),
        interests: doc.get("interests"),
        toys: <Toy>[],
        profileImageUrl: doc.get("profileImageUrl")
    )).toList();
    List<Toy> toysList = [];
    /*r(var i = 0; i < profileInfoList.length; i++){
      var checkProfileInfo = profileInfoList[i];
      if(checkProfileInfo.userId == profileInfo.userId)
        continue;
      for(var j =0; j < checkProfileInfo.toys.length; j++){
        var toy = checkProfileInfo.toys[j];
        for (var k =0; k < toy.categories.length; k++){
          var toyCategory = toy.categories[k];
          if (profileInfo.interests.contains(toyCategory)){
            toysList.add(toy);
            break;
          }
        }
      if(toy.ageRange == profileInfo.ageRange)
        toysList.add(toy);
      }
    }
   */return toysList;
  }

  Future<bool> addToyData(Toy toy, ProfileInfo profileInfo, File? toyImage,) async {
    if(toyImage != null) {
      final storage = FirebaseStorage.instance.ref('users').child(
          profileInfo.uid).child('toys').child(toy.toyId);
      await storage.putFile(toyImage);
      final toyImgURL = (await storage.getDownloadURL()).toString();
      toy.toyImageURL = toyImgURL;
    }
    print(profileInfo.toys);
    profileInfo.toys.add(toy);
    print(profileInfo.toJson());
    try {
      await setProfileInfo(profileInfo.toJson(), null);
      return true;
    }
    on Exception catch(_) {
      return false;
    }
  }

  getToyList(){
    return toyList;
  }


  Future deleteToy(String toyId) async{
    toyList.removeWhere((item) => item.id == '0');
    try{
      return await FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid).collection('toys')
          .doc(toyId).delete();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<bool> sendTextMessage(TextMessage textMessage) async {
    try{

      var conversation = Conversation(Uuid().v4(), textMessage.receiverId, textMessage.message, textMessage.time);
      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.senderId).collection('conversations').doc(conversation.conversationId).set(conversation.toJson());

      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.receiverId).collection('conversations').doc(conversation.conversationId).set(conversation.toJson());

      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.senderId).collection('conversations').doc(conversation.conversationId).collection('messages').doc(textMessage.messageId).set(textMessage.toJson());

      await FirebaseFirestore.instance.collection('users')
          .doc(textMessage.receiverId).collection('conversations').doc(conversation.conversationId).collection('messages').doc(textMessage.messageId).set(textMessage.toJson());

      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }
}
