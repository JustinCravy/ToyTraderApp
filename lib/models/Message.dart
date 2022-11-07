
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'Message.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Message {

  String messageId = '';
  String senderId = '';
  String receiverId = '';
  String time = '';
  String type = '';

  Message (
      this.messageId,
      this.senderId,
      this.receiverId,
      this.time,
      this.type,
      );

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

}

class ImageMessage extends Message{
  String image;
  ImageMessage(
      messageId,
      senderId,
      receiverId,
      time,
      type,
      this.image) : super(messageId, senderId, receiverId, time, type);

}

