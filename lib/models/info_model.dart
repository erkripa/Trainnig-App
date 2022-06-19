// To parse this JSON data, do
//
//     final infoModel = infoModelFromJson(jsonString);

import 'dart:convert';

List<InfoModel> infoModelFromJson(String str) =>
    List<InfoModel>.from(json.decode(str).map((x) => InfoModel.fromJson(x)));

String infoModelToJson(List<InfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfoModel {
  InfoModel({
    this.id,
    this.img,
    this.title,
  });

  int? id;
  String? img;
  String? title;

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        id: json["id"],
        img: json["img"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "title": title,
      };
}
