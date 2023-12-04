class MessageModel {
  final String text;

  final String userId;

  final int datetime;

  final String? messageId;

  MessageModel({
    required this.text,
    required this.userId,
    required this.datetime,
    this.messageId,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        userId = json["userId"],
        datetime = json["datetime"],
        messageId = json["messageId"];

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "userId": userId,
      "datetime": datetime,
      "messageId": messageId,
    };
  }
}
