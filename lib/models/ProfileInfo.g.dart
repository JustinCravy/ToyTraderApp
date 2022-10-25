// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfo _$ProfileInfoFromJson(Map json) => ProfileInfo(
      uid: json['uid'] as String,
      screenName: json['screenName'] as String,
      ageRange: json['ageRange'] as String,
      interests: json['interests'] as String,
      toys: (json['toys'] as List<dynamic>)
          .map((e) => Toy.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      profileImageUrl: json['profileImageUrl'] as String,
    );

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'screenName': instance.screenName,
      'ageRange': instance.ageRange,
      'interests': instance.interests,
      'toys': instance.toys.map((e) => e.toJson()).toList(),
      'profileImageUrl': instance.profileImageUrl,
    };
