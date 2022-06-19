import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training/utils/colors.dart';
import 'package:training/utils/dimension.dart';

import '../../controllers/detail_page_controller.dart';
import 'components/methods.dart';
import 'components/video_card_list_tile.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<DetailPageController>().getVideoList();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.gradientFirst.withOpacity(0.9),
              AppColor.gradientSecond,
            ],
            begin: FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFirstHalfSection(),
            //
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: D.h20 * 2),
                decoration: BoxDecoration(
                  color: AppColor.homePageBackground,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(D.w20 * 4),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: D.p20,
                    left: D.p20,
                    right: D.w10 * 3,
                  ),
                  child: GetBuilder<DetailPageController>(
                      builder: (_detailPageController) {
                    return Column(
                      children: [
                        buildHeadinAndIconWithText(),
                        _detailPageController.isLoded
                            ? Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        _detailPageController.videoList.length,
                                    itemBuilder: (_, index) {
                                      final videoModel = _detailPageController
                                          .videoList[index];
                                      return VideoCardListTile(
                                        title: videoModel.title,
                                        thumbnail: videoModel.thumbnail,
                                        time: videoModel.time,
                                        videoUrl: videoModel.videoUrl,
                                      );
                                    }),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: D.sHeight / 4),
                                child: CircularProgressIndicator()),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildFirstHalfSection() {
    return Column(
            children: [
              detailAppBar(),
              buildDetailPageTitle(),
              buildTwoBtn(),
            ],
          );
  }
}
