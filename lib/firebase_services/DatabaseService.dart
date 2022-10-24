
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../models/Toy.dart';


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

    final storage = FirebaseStorage.instance.ref('users').child(profileInfo.userId);
    await storage.putFile(imageFile!);
    final profileImgUrl = (await storage.getDownloadURL()).toString();
    profileInfo.profileImageUrl = profileImgUrl;

    return await FirebaseFirestore.instance.collection('users').doc(profileInfo.userId).set({
      'screenName': profileInfo.screenName,
      'ageRange': profileInfo.ageRange,
      'interests': profileInfo.interests,
      'toys': profileInfo.toys,
      'profileImage': profileInfo.profileImageUrl
    });
  }


  Future<ProfileInfo> getProfileInfo(String userId) async {
    if (userId.isEmpty) {
      var user = FirebaseAuth.instance.currentUser?.uid;
      var query = await FirebaseFirestore.instance.collection('users')
          .where('uid', isEqualTo: user).get();
      var userData = query.docs.map((doc) => doc).toList();

      final profileInfo = ProfileInfo(userId: userData[0].id,
          screenName: userData[0].get("screenName"),
          ageRange: userData[0].get("ageRange"),
          interests: userData[0].get("interests"),
          toys: [],
          profileImageUrl: userData[0].get("profileImage"));

      return profileInfo;
    }

    var query = await FirebaseFirestore.instance.collection('users')
        .where('uid', isEqualTo: userId).get();
    var userData = query.docs.map((doc) => doc).toList();

    final profileInfo = ProfileInfo(userId: userData[0].id,
        screenName: userData[0].get("screenName"),
        ageRange: userData[0].get("ageRange"),
        interests: userData[0].get("interests"),
        toys: [],
        profileImageUrl: userData[0].get("profileImage"));

    return profileInfo;
  }

  Future<List<Toy>> getMainFeed() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    final profileInfoList = querySnapshot.docs.map((doc) => ProfileInfo(
        userId: doc.id,
        screenName: doc.get("screenName"),
        ageRange: doc.get("ageRange"),
        interests: doc.get("interests"),
        toys: <Toy>[],
        profileImageUrl: doc.get("profileImage")
    )).toList();
    toyList = [];
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
   */return toyList;
  }

  Future<bool> addToyData(Toy toy, ProfileInfo profileInfo, File? toyImage,) async {
    final storage = FirebaseStorage.instance.ref('users').child(profileInfo.userId).child('toys');
    await storage.putFile(toyImage!);
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
  void deleteToy(){
    toyList.removeWhere((item) => item.id == '0');
  }


}
