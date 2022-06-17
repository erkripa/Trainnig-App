import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widgets/bigtext.dart';
import '../../../widgets/smalltext.dart';

class FigureCardWidget extends StatelessWidget {
  const FigureCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: D.h20 * 8,
      width: D.sWidth,
      margin: EdgeInsets.only(top: D.h10),
      child: Stack(
        children: [
          Container(
            height: D.h20 * 6,
            margin: EdgeInsets.only(top: D.h20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(D.h20),
                image: DecorationImage(
                  image: AssetImage('assets/card.png'),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.gradientSecond.withOpacity(0.2),
                    offset: Offset(8, 10),
                    blurRadius: 40,
                  ),
                  BoxShadow(
                    color: AppColor.gradientSecond.withOpacity(0.2),
                    offset: Offset(-1, -10),
                    blurRadius: 10,
                  )
                ]),
          ),
          Container(
            margin: EdgeInsets.only(bottom: D.h10 * 3, right: D.h20 * 9),
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/figure.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(left: D.w15 * 9, top: D.h20 * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: 'You are doing great',
                  isFontWeight: true,
                  textColor: AppColor.homePageDetail,
                  fontSize: D.f18,
                ),
                SizedBox(height: D.h5),
                SmallText(
                  text: 'keep it up\nstick to your plan',
                  textColor: AppColor.homePagePlanColor,
                  isFontWeight: true,
                  fontSize: D.f16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
