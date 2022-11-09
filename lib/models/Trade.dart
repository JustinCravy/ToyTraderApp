import 'Toy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Trade.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Trade {
  List<Toy> senderToys;
  List<Toy> recieverToys;
  String tradeStatus;

  Trade(
      this.senderToys,
      this.recieverToys,
      this.tradeStatus
      );

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
  Map<String, dynamic> toJson() => _$TradeToJson(this);
}