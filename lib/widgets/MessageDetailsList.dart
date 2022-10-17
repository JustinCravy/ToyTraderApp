class MessageDetailsList {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const MessageDetailsList({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });
}