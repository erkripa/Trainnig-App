import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/bigtext.dart';
import '../../../widgets/smalltext.dart';

class MainCardWidget extends StatelessWidget {
  const MainCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: D.sHeight / 4,
      width: double.maxFinite,
      padding:
          EdgeInsets.only(top: D.p20, left: D.w20, right: D.w20, bottom: D.p20),
      margin: EdgeInsets.only(top: D.h15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.gradientFirst,
            AppColor.gradientSecond.withOpacity(0.99),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(D.w10),
          topRight: Radius.circular(D.w20 * 4),
          bottomLeft: Radius.circular(D.w10),
          bottomRight: Radius.circular(D.w10),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 10),
            blurRadius: 20,
            color: AppColor.gradientSecond.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: 'Next Workout',
            textColor: AppColor.homePageContainerTextSmall,
          ),
          SizedBox(height: D.h10),
          BigText(
            text: 'Legs Toning',
            textColor: AppColor.homePageContainerTextSmall,
            fontSize: D.f25,
          ),
          SizedBox(height: D.h5),
          BigText(
            text: 'and Glutes Workout',
            textColor: AppColor.homePageContainerTextSmall,
            fontSize: D.f25,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  AppIcon(
                    icon: Icons.timer_outlined,
                    iconColor: Colors.white,
                  ),
                  SizedBox(width: D.w5),
                  SmallText(
                      text: '60 min',
                      textColor: AppColor.homePageContainerTextSmall)
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(D.f20 * 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.gradientFirst,
                      offset: Offset(4, 8),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: AppIcon(
                  icon: Icons.play_circle_fill_rounded,
                  iconColor: Colors.white,
                  iconSize: D.f20 * 2.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
