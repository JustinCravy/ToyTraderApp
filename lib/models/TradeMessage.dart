import 'package:toy_trader/models/Trade.dart';

import 'Message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TradeMessage.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class TradeMessage extends Message {

  Trade trade = Trade([], [], 'OPEN');

  TradeMessage (
      messageId,
      senderId,
      receiverId,
      time,
      type,
      this.trade
      ) : super(messageId, senderId, receiverId, time, type);


  factory TradeMessage.fromJson(Map<String, dynamic> json) => _$TradeMessageFromJson(json);
  Map<String, dynamic> toJson() => _$TradeMessageToJson(this);

}