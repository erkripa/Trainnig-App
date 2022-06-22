import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:training/models/video_model.dart';
import 'package:training/utils/colors.dart';
import 'package:training/utils/dimension.dart';
import 'package:training/widgets/app_icon.dart';
import 'package:training/widgets/bigtext.dart';
import 'package:training/widgets/smalltext.dart';
import 'package:video_player/video_player.dart';

import '../widgets/show_message.dart';

class DetailPageController extends GetxController {
  List<VideoModel> _videoList = [];
  List<VideoModel> get videoList => _videoList;

  bool _isLoded = false;
  bool get isLoded => _isLoded;

  bool _playArea = false;
  bool get playArea => _playArea;

  VideoPlayerController? _controller;
  VideoPlayerController? get videPlayController => _controller;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  bool _disposed = false;
  bool get disposed => _disposed;

  var _onControllerUpdateTime;
  int _isPlayingIndex = -1;

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

  void changePlayArea() {
    _playArea = true;
    update();
  }

  set setPlayArea(bool newPlayArea) {
    _playArea = newPlayArea;
    update();
  }

  void videoInitialized(int index) {
    final videoUrl = _videoList[index].videoUrl;
    final controller = VideoPlayerController.network(videoUrl!);
    final oldController = _controller;
    _controller = controller;

    if (oldController != null) {
      oldController.removeListener(_onControllerUpdate);
      oldController.pause();
      log('old controller removed');
    }
    controller
      ..initialize().then((_) {
        oldController?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
      });
    update();
  }

  void onLeftBtnClicked() {
    final index = _isPlayingIndex - 1;
    if (index >= 0 && videoList.length >= 0) {
      videoInitialized(index);
    } else {
      showMessage(
        "Video",
        "No more video to play",
      );
    }
  }

  void onRightBtnClicked() {
    final index = _isPlayingIndex + 1;
    if (index <= videoList.length - 1) {
      videoInitialized(index);
    } else {
      showMessage(
        "Video",
        "You have finished watching all the videos. Congratulation!",
      );
    }
  }

  void changePlayBtn() {
    if (_isPlaying) {
      _controller!.pause();
      _isPlaying = false;
      update();
    } else {
      _controller!.play();
      _isPlaying = true;
      update();
    }
  }

  void _onControllerUpdate() async {
    if (disposed) {
      log('diposed1');
      return;
    }
    _onControllerUpdateTime = 0;
    update();
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onControllerUpdateTime > 0) {
      log('old controller has greter than 0');
      return;
    }
    _onControllerUpdateTime = now + 500;
    update();
    final controller = _controller;

    if (controller == null) {
      log('controller is null');
      return;
    }

    if (!controller.value.isInitialized) {
      log('controller can not be initialized');
      return;
    }

    final playing = controller.value.isPlaying;
    _isPlaying = playing;

    update();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller!.pause();
    _controller!.dispose();
    super.dispose();
    log('disposed');
  }

  bool get noMute {
    return (_controller?.value.volume ?? 0) > 0;
  }

  void onTapVolumBtn() {
    if (noMute) {
      _controller?.setVolume(0);
    } else {
      _controller?.setVolume(1.0);
    }
  }
}
