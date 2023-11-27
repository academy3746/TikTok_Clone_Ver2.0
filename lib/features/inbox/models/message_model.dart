class MessageModel {
  final String text;

  final String userId;

  final int datetime;

  MessageModel({
    required this.text,
    required this.userId,
    required this.datetime,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        userId = json["userId"],
        datetime = json["datetime"];

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "userId": userId,
      "datetime": datetime,
    };
  }
}
