import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    Key? key,
    this.text,
    this.fontSize,
    this.textColor = AppColor.homePageTitle,
    this.isFontWeight = false,
  }) : super(key: key);

  final String? text;
  final double? fontSize;
  final Color textColor;
  final bool isFontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: kTitleTextStyle,
    );
  }

  TextStyle get kTitleTextStyle => TextStyle(
        color: textColor,
        fontSize: fontSize == null ? D.f14 : fontSize,
        height: 1.4,
        fontWeight: isFontWeight ? FontWeight.w500 : FontWeight.normal,
      );
}
