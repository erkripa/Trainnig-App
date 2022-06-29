import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:training/models/video_model.dart';
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

  set controllerTonull(value) {
    _controller = value;
    update();
  }

  VideoPlayerController? oldController;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  bool _disposed = false;
  bool get disposed => _disposed;

  var _onControllerUpdateTime;
  int _isPlayingIndex = -1;

  Duration? _duration;
  Duration? get duration => _duration;
  Duration? _position;
  Duration? get position => _position;
  double _progress = 0.0;
  double get progress => _progress;

  String _videoTitle = "";
  String get videoTitle => _videoTitle;

  late Future<List<VideoModel>> _futureOfVideoList;
  Future<List<VideoModel>> get futureOfVideoList => _futureOfVideoList;

  @override
  void onInit() {
    initvideolist();
    super.onInit();
  }

  Future<void> initvideolist() async {
    _futureOfVideoList = getVideoListFromFirebase();
  }

  Future<List<VideoModel>> getVideoListFromFirebase() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('videos').get();

    List<VideoModel> videoList = [];

    videoList.addAll(snapshot.docs
        .map((docSnapshot) => VideoModel.fromDocumentSnapshot(docSnapshot))
        .toList());
    _videoList = [];
    _videoList.addAll(videoList);
    _isLoded = true;
    print("length of video List = " + _videoList.length.toString());

    update();

    return videoList;
  }

  void changePlayArea() {
    _playArea = true;
    update();
  }

  set setPlayArea(bool newPlayArea) {
    _playArea = newPlayArea;
  }

  void videoInitialized(int index) async {
    _videoTitle = _videoList[index].title!;
    final videoUrl = _videoList[index].videoUrl;
    final controller = VideoPlayerController.network(videoUrl!);
    oldController = _controller;
    _controller = controller;
    update();
    if (oldController != null) {
      oldController?.removeListener(_onControllerUpdate);
      print('old controller removed');
    }
    controller
      ..initialize().then((_) {
        oldController?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        update();
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
    print("index" + _isPlayingIndex.toString());
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
    _onControllerUpdateTime = 0;
    update();
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onControllerUpdateTime > 0) {
      print('old controller has greter than 0');
      return;
    }
    _onControllerUpdateTime = now + 500;
    update();

    final controller = _controller;

    if (controller == null) {
      print('controller is null');
      return;
    }

    if (!controller.value.isInitialized) {
      print('controller can not be initialized');
      return;
    }

    final playing = controller.value.isPlaying;

    _isPlaying = playing;

    update();
  }

  @override
  void dispose() {
    print('disposed');
    _controller!.pause();
    _controller!.dispose();
    setPlayArea = false;
    _controller = null;
    super.dispose();
  }

  void customDispose() {
    setPlayArea = false;
    videPlayController?.dispose();
    update();
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

  void onChangedProgress(double value) {
    _progress = value * 0.01;
    update();
  }

  void onChangeStart(double value) {
    _controller?.pause();
  }

  void onChangeEnd(double value) {
    final duration = _controller?.value.duration;
    if (duration != null) {
      var newValue = max(0, min(value, 99)) * 0.01;
      var millis = (duration.inMicroseconds * newValue).toInt();
      _controller?.seekTo(Duration(microseconds: millis));
      _controller?.play();
    }
  }
}
