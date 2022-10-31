// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TextMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map json) => TextMessage(
      json['messageId'],
      json['senderId'],
      json['receiverId'],
      json['time'],
      json['type'],
      json['message'] as String,
    );

Map<String, dynamic> _$TextMessageToJson(TextMessage instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'time': instance.time,
      'type': instance.type,
      'message': instance.message,
    };
