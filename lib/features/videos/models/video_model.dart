class VideoModel {
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

  Map<String, dynamic> toJson() {
    return {
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
