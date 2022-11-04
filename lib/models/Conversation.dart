import 'package:json_annotation/json_annotation.dart';
part 'Conversation.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Conversation {
  String otherUserId = '';
  String lastMessage = '';
  String time = '';

  Conversation (
      this.otherUserId,
      this.lastMessage,
      this.time,
      );

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
