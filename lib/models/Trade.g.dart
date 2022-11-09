// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trade _$TradeFromJson(Map json) => Trade(
      (json['senderToys'] as List<dynamic>)
          .map((e) => Toy.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      (json['recieverToys'] as List<dynamic>)
          .map((e) => Toy.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['tradeStatus'] as String,
    );

Map<String, dynamic> _$TradeToJson(Trade instance) => <String, dynamic>{
      'senderToys': instance.senderToys.map((e) => e.toJson()).toList(),
      'recieverToys': instance.recieverToys.map((e) => e.toJson()).toList(),
      'tradeStatus': instance.tradeStatus,
    };
