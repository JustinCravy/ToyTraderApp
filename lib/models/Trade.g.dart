// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map json) => Trade(
      json['tradeId'] as String,
      json['senderId'] as String,
      json['senderName'] as String,
      json['senderProfileImgUrl'] as String,
      json['receiverId'] as String,
      json['receiverName'] as String,
      json['receiverProfileImgUrl'] as String,
      (json['senderToys'] as List<dynamic>)
          .map((e) => Toy.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      (json['receiverToys'] as List<dynamic>)
          .map((e) => Toy.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['tradeStatus'] as String,
      json['date'] as String,
      json['senderRatingRcvd'] as bool,
      json['receiverRatingRcvd'] as bool,
    );

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'tradeId': instance.tradeId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderProfileImgUrl': instance.senderProfileImgUrl,
      'receiverId': instance.receiverId,
      'receiverName': instance.receiverName,
      'receiverProfileImgUrl': instance.receiverProfileImgUrl,
      'senderToys': instance.senderToys.map((e) => e.toJson()).toList(),
      'receiverToys': instance.receiverToys.map((e) => e.toJson()).toList(),
      'tradeStatus': instance.tradeStatus,
      'date': instance.date,
      'senderRatingRcvd': instance.senderRatingRcvd,
      'receiverRatingRcvd': instance.receiverRatingRcvd,
    };
