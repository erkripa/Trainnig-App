import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training/routes/app_route.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/bigtext.dart';

class AppMethod {
  static Row get firstHeadingMethod {
    return Row(
      children: [
        BigText(
          text: 'Your Program',
          isFontWeight: true,
        ),
        Spacer(),
        BigText(
          text: 'Details',
          textColor: AppColor.homePageDetail,
          isFontWeight: true,
        ),
        SizedBox(width: D.w5),
        AppIcon(
            onPressed: () => Get.toNamed(AppRoute.getDetailPage()),
            icon: Icons.arrow_forward_rounded)
      ],
    );
  }
}
