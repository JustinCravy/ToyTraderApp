// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TradeMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeMessage _$TradeMessageFromJson(Map json) => TradeMessage(
      json['messageId'],
      json['senderId'],
      json['receiverId'],
      json['time'],
      json['type'],
      Trade.fromJson(Map<String, dynamic>.from(json['trade'] as Map)),
    );

Map<String, dynamic> _$TradeMessageToJson(TradeMessage instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'time': instance.time,
      'type': instance.type,
      'trade': instance.trade.toJson(),
    };
