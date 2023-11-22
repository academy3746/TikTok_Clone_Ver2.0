class VideoModel {
  final String id;
  final String title;
  final String description;
  final String fileUrl;
  final String thumbUrl;
  final String creatorUid;
  final String creator;
  final int likes;
  final int comments;
  final int datetime;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbUrl,
    required this.creatorUid,
    required this.creator,
    required this.likes,
    required this.comments,
    required this.datetime,
  });

  VideoModel.fromJson({
    required Map<String, dynamic> json,
    required String videoId,
  })  : id = videoId,
        title = json["title"],
        description = json["description"],
        fileUrl = json["fileUrl"],
        thumbUrl = json["thumbUrl"],
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        likes = json["likes"],
        comments = json["comments"],
        datetime = json["datetime"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumbUrl": thumbUrl,
      "creatorUid": creatorUid,
      "creator": creator,
      "likes": likes,
      "comments": comments,
      "datetime": datetime
    };
  }
}
