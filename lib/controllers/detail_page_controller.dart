import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:training/models/video_model.dart';

class DetailPageController extends GetxController {
  List<VideoModel> _videoList = [];
  List<VideoModel> get videoList => _videoList;

  bool _isLoded = false;
  bool get isLoded => _isLoded;

  Future<void> getVideoList() async {
    try {
      String response = await rootBundle.loadString('json/videoinfo.json');
      _videoList = [];
      _videoList.addAll(videoModelFromJson(response));
      _isLoded = true;
      await Future.delayed(Duration(milliseconds: 1500));
      update();
    } catch (e) {
      log("Error Catch during load video json = " + e.toString());
    }
  }
}
