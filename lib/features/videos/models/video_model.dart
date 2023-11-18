class VideoModel {
  final String title;
  final String fileUrl;
  final String thumbUrl;
  final String creatorUid;
  final int likes;
  final int comments;
  final int datetime;

  VideoModel({
    required this.title,
    required this.fileUrl,
    required this.thumbUrl,
    required this.creatorUid,
    required this.likes,
    required this.comments,
    required this.datetime,
  });
}
