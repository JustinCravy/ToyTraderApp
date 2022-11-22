import 'Toy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Trade.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Trade {

  String tradeId;
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;
  String receiverProfileImgUrl;
  List<Toy> senderToys;
  List<Toy> receiverToys;
  String tradeStatus;
  String date;

  Trade(
      this.tradeId,
      this.senderId,
      this.senderName,
      this.receiverId,
      this.receiverName,
      this.receiverProfileImgUrl,
      this.senderToys,
      this.receiverToys,
      this.tradeStatus,
      this.date
      );

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
  Map<String, dynamic> toJson() => _$TradeToJson(this);
}