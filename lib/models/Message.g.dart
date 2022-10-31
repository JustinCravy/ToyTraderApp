// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map json) => Message(
      json['messageId'] as String,
      json['senderId'] as String,
      json['receiverId'] as String,
      json['time'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'time': instance.time,
      'type': instance.type,
    };
