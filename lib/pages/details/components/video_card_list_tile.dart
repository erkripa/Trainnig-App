
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widgets/bigtext.dart';
import '../../../widgets/smalltext.dart';

class VideoCardListTile extends StatelessWidget {
  const VideoCardListTile({
    Key? key,
    this.title,
    this.time,
    this.thumbnail,
    this.videoUrl,
  }) : super(key: key);

  final String? title;
  final String? time;
  final String? thumbnail;
  final String? videoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: D.h20 * 4,
              width: D.w20 * 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(D.w10),
                color: AppColor.homePagePlanColor,
                image: DecorationImage(
                  image: AssetImage(thumbnail!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: BigText(
              text: title,
            ),
            subtitle: SmallText(
              text: time,
              textColor: AppColor.homePagePlanColor,
            ),
          ),
          SizedBox(height: D.h10 / 2),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: D.p10,
                  vertical: D.p8 / 3,
                ),
                decoration: BoxDecoration(
                  color: AppColor.secondPageContainerGradient1stColor
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(D.w20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: '15s rest',
                      fontSize: D.f12,
                      isFontWeight: true,
                      isLessFontWeight: true,
                      textColor: AppColor.secondPageContainerGradient1stColor
                          .withOpacity(0.8),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < 25; i++)
                Container(
                  width: 3,
                  height: 1,
                  margin: EdgeInsets.only(right: D.w5),
                  decoration: BoxDecoration(
                    color: AppColor.secondPageContainerGradient2ndColor
                        .withOpacity(0.7),
                    borderRadius: BorderRadius.circular(D.w20),
                  ),
                ),
            ],
          ),
          SizedBox(height: D.h5 / 2),
        ],
      ),
    );
  }
}
