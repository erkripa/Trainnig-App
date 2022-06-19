import 'package:flutter/material.dart';

import '../../../utils/dimension.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/bigtext.dart';

AppBar appBar() {
  return AppBar(
    title: BigText(
      text: 'Training',
      fontSize: D.f25,
      isFontWeight: true,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      AppIcon(icon: Icons.arrow_back_ios_new_rounded, padding: D.p8),
      AppIcon(icon: Icons.today_rounded),
      AppIcon(icon: Icons.arrow_forward_ios, padding: D.p8),
      SizedBox(width: D.w10),
    ],
  );
}
