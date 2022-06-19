import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/bigtext.dart';
import '../../../widgets/smalltext.dart';

Container buildIconWithText(IconData icon, String text, [double width = 0]) {
  return Container(
    height: D.h15 * 2,
    width: width == 0 ? D.w10 * 9 : width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(D.p10),
      gradient: LinearGradient(
        colors: [
          AppColor.secondPageContainerGradient1stColor,
          AppColor.secondPageContainerGradient2ndColor,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topCenter,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcon(
          icon: icon,
          iconColor: AppColor.secondPageIconColor,
        ),
        SizedBox(width: D.w5),
        SmallText(
          text: text,
          textColor: AppColor.secondPageIconColor,
        )
      ],
    ),
  );
}

Row buildHeadinAndIconWithText() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      BigText(
        text: 'Circuits 1 : Legs Toining',
        isFontWeight: true,
        isLessFontWeight: true,
        fontSize: D.f18,
        textColor: AppColor.circuitsColor,
      ),
      Row(
        children: [
          AppIcon(
            icon: Icons.loop_rounded,
            iconColor: AppColor.loopColor,
            iconSize: D.h10 * 3,
          ),
          SizedBox(width: D.w5),
          SmallText(
            text: '3 sets',
            isFontWeight: true,
            textColor: AppColor.setsColor,
          ),
        ],
      )
    ],
  );
}

AppBar detailAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: AppIcon(
      onPressed: () => Get.back(),
      icon: Icons.arrow_back_ios,
      iconColor: AppColor.secondPageTopIconColor,
    ),
    actions: [
      AppIcon(
        icon: Icons.info_outline_rounded,
        padding: D.p10,
        iconColor: AppColor.secondPageTopIconColor,
      ),
    ],
  );
}

Container buildTwoBtn() {
  return Container(
    padding: EdgeInsets.only(left: D.p20, top: D.p20 * 1.5),
    child: Row(
      children: [
        buildIconWithText(Icons.timer, '68 min'),
        SizedBox(width: D.w10),
        buildIconWithText(
          Icons.handyman_outlined,
          'Resistent band ,Kettelbel',
          D.sWidth / 1.8,
        ),
      ],
    ),
  );
}

Container buildDetailPageTitle() {
  return Container(
    padding: EdgeInsets.only(
      left: D.w20,
    ),
    child: BigText(
      text: 'Legs Toing\nand Glutes Workout',
      fontSize: D.f25,
      textColor: AppColor.secondPageTitleColor,
    ),
  );
}
