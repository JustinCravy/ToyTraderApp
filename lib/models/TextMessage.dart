import 'Message.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TextMessage.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class TextMessage extends Message {

  String message = '';

  TextMessage (
      messageId,
      senderId,
      receiverId,
      time,
      type,
      this.message
      ) : super(messageId, senderId, receiverId, time, type);


  factory TextMessage.fromJson(Map<String, dynamic> json) => _$TextMessageFromJson(json);
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);

}
