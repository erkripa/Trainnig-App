// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

List<VideoModel> videoModelFromJson(String str) =>
    List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

String videoModelToJson(List<VideoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoModel {
  VideoModel({
    this.title,
    this.time,
    this.thumbnail,
    this.videoUrl,
  });

  final String? title;
  final String? time;
  final String? thumbnail;
  final String? videoUrl;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        title: json["title"],
        time: json["time"],
        thumbnail: json["thumbnail"],
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "time": time,
        "thumbnail": thumbnail,
        "videoUrl": videoUrl,
      };
}
