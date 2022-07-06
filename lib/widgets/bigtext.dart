import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';

class BigText extends StatelessWidget {
  const BigText({
    Key? key,
    this.text,
    this.fontSize,
    this.textColor = AppColor.homePageTitle,
    this.isFontWeight = false,
    this.isLessFontWeight = false,
    this.height = 0,
  }) : super(key: key);

  final String? text;
  final double? fontSize;
  final double? height;
  final Color textColor;
  final bool isFontWeight;
  final bool isLessFontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: kTitleTextStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  TextStyle get kTitleTextStyle => TextStyle(
        color: textColor,
        fontSize: fontSize == null ? D.f16 : fontSize,
        fontWeight: isFontWeight
            ? isLessFontWeight
                ? FontWeight.w500
                : FontWeight.w700
            : FontWeight.normal,
        height: height == 0 ? 0 : height,
      );
}
