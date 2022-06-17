import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    Key? key,
    required this.icon,
    this.onPressed,
    this.padding = 0,
    this.iconSize = 0,
    this.iconColor = AppColor.homePageIcons,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;
  final double? padding;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      splashRadius: D.h20,
      iconSize: iconSize == 0 ? D.f20 : iconSize,
      padding: EdgeInsets.all(padding!),
      splashColor: AppColor.gradientFirst.withOpacity(0.2),
      constraints: BoxConstraints(),
      
      icon: Icon(
        icon,
        color: iconColor,
        
      ),
    );
  }
}
