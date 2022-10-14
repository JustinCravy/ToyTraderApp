import 'dart:io';

import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {


  Future setProfileInfo(ProfileInfo profileInfo, File imageFile) async {

    final storage = FirebaseStorage.instance.ref('users').child(profileInfo.userId);
    await storage.putFile(imageFile);
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
}