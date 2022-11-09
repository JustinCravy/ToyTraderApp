// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageMessage _$ImageMessageFromJson(Map json) => ImageMessage(
      json['messageId'],
      json['senderId'],
      json['receiverId'],
      json['time'],
      json['type'],
      json['imageUrl'] as String,
    );

Map<String, dynamic> _$ImageMessageToJson(ImageMessage instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'time': instance.time,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
    };
