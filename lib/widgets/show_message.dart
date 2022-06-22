import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
import 'app_icon.dart';
import 'bigtext.dart';
import 'smalltext.dart';

SnackbarController showMessage(
  String title,
  String message,
) {
  return Get.snackbar(
    title,
    message,
    titleText: BigText(
      text: title,
      textColor: Colors.white,
      isFontWeight: true,
    ),
    messageText: BigText(
      text: message,
      textColor: AppColor.secondPageIconColor,
      isFontWeight: true,
      isLessFontWeight: true,
      fontSize: D.f14,
      height: 1.2,
    ),
    backgroundColor: AppColor.gradientSecond,
    icon: AppIcon(
      icon: Icons.face_outlined,
      iconSize: D.h25 * 1.2,
      iconColor: Colors.white,
    ),
    snackPosition: SnackPosition.BOTTOM,
  );
}
