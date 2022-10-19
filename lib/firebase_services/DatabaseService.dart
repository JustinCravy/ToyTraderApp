import 'dart:io';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Toy.dart';

class DatabaseService {


  Future setProfileInfo(ProfileInfo profileInfo, File imageFile) async {
    final storage = FirebaseStorage.instance.ref('users').child(
        profileInfo.userId);
    await storage.putFile(imageFile);
    final profileImgUrl = (await storage.getDownloadURL()).toString();
    profileInfo.profileImageUrl = profileImgUrl;

    return await FirebaseFirestore.instance.collection('users').doc(
        profileInfo.userId).set({
      'screenName': profileInfo.screenName,
      'ageRange': profileInfo.ageRange,
      'interests': profileInfo.interests,
      'toys': profileInfo.toys,
      'profileImage': profileInfo.profileImageUrl
    });
  }

  Future<List<ProfileInfo>> getProfileInfo(String userId) async {
    if (userId.isEmpty) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

      final dataList = querySnapshot.docs.map((doc) => doc).toList();

      final List<ProfileInfo> profileInfoList = [];

      for (var i = 0; i < dataList.length; i++) {
        var toys = dataList[i].get("toys");
        //List<Toy> userToys = List<Toy>.from(toys);

        var profileInfo = ProfileInfo(userId: dataList[i].id,
            screenName: dataList[i].get("screenName"),
            ageRange: dataList[i].get("ageRange"),
            interests: dataList[i].get("interests"),
            toys: userToys,
            profileImageUrl: dataList[i].get("profileImage")
        );

        profileInfoList.add(profileInfo);
      }

      return profileInfoList;
    }

    throw new Error();
  }
}
