// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';

void main() {
  group("Video Model Test", () {
    test("Constructor", () {
      final video = VideoModel(
          id: "id",
          title: "title",
          description: "description",
          fileUrl: "fileUrl",
          thumbnailUrl: "thumbnailUrl",
          likes: 0,
          comments: 0,
          creatorUid: "creatorUid",
          createdAt: 111222333,
          creator: "creator");

      expect(video.id, "id");
    });

    test("fromJson", () {
      final video = VideoModel.fromJson({
        "id": "id",
        "title": "title",
        "description": "description",
        "fileUrl": "fileUrl",
        "thumbnailUrl": "thumbnailUrl",
        "likes": 0,
        "comments": 0,
        "creatorUid": "creatorUid",
        "createdAt": 111222333,
        "creator": "creator"
      });

      expect(video.title, "title");
      expect(video.comments, isInstanceOf<int>());
    });

    test("toJson" , () {
      final video = VideoModel(
          id: "id",
          title: "title",
          description: "description",
          fileUrl: "fileUrl",
          thumbnailUrl: "thumbnailUrl",
          likes: 0,
          comments: 0,
          creatorUid: "creatorUid",
          createdAt: 111222333,
          creator: "creator");

      Map<String, dynamic> json = video.toJson();
      expect(json["id"],  video.id);
      expect(json["likes"],  isInstanceOf<int>());
    });
  });

  /*
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    test("Test Video Model Constructor", () {
    });
  });
  */
}
