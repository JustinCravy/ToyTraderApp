import 'dart:io';

import 'package:firebase/firebase.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/Toy.dart';
import '../screens/AddToyScreen.dart';

class DatabaseService {


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
    final storage = FirebaseStorage.instance.ref('users').child(profileInfo.userId).child('toys');
    await storage.putFile(toyImage!);
    final toyImageURL = (await storage.getDownloadURL()).toString();
    toy.toyImageURL = toyImageURL;
    profileInfo.toys.add(toy);
    try {
      await setProfileInfo(profileInfo, null);
      return true;
    }
    on Exception catch(_) {
      return false;
    }
  }
}
