import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:training/models/info_model.dart';

class HomePageController extends GetxController {
  List<InfoModel> _infoList = [];
  List<InfoModel> get infoList => _infoList;

  bool _isLoded = false;
  bool get isLoded => _isLoded;

  Future<void> getInfoList() async {
    try {
      String response = await rootBundle.loadString('json/info.json');
      _infoList = [];
      _infoList.addAll(infoModelFromJson(response));
      _isLoded = true;
      await Future.delayed(Duration(milliseconds: 1500));
      update();
    } catch (e) {
      log("Error Catch during load json = " + e.toString());
    }
  }
}
