import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

void main() {
  test("Video Model Constructor Test", () {
    final video = VideoModel(
      id: "testId",
      title: "testTitle",
      description: "testDescription",
      fileUrl: "testFileUrl",
      thumbUrl: "testThumbUrl",
      creatorUid: "testCreatorUid",
      creator: "testCreator",
      likes: 1,
      comments: 1,
      datetime: DateTime.now().microsecondsSinceEpoch,
    );

    expect(video.id, "id");
  });
}
