// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Toy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Toy _$ToyFromJson(Map json) => Toy(
      json['toyId'] as String,
      json['ownerId'] as String,
      json['name'] as String,
      json['description'] as String,
      json['condition'] as String,
      json['ageRange'] as String,
      json['categories'] as String,
      json['toyImageURL'] as String,
    );

Map<String, dynamic> _$ToyToJson(Toy instance) => <String, dynamic>{
      'toyId': instance.toyId,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'condition': instance.condition,
      'ageRange': instance.ageRange,
      'categories': instance.categories,
      'toyImageURL': instance.toyImageURL,
    };
