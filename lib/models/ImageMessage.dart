

import 'package:json_annotation/json_annotation.dart';
import 'Message.dart';
part 'ImageMessage.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ImageMessage extends Message{
  String imageUrl = '';
  ImageMessage(
      messageId,
      senderId,
      receiverId,
      time,
      type,
      this.imageUrl) : super(messageId, senderId, receiverId, time, type);

  factory ImageMessage.fromJson(Map<String, dynamic> json) => _$ImageMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageMessageToJson(this);
}
