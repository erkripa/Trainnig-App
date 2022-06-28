import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training/pages/home/components/methods.dart';
import 'package:training/utils/colors.dart';
import 'package:training/utils/dimension.dart';

import '../../controllers/detail_page_controller.dart';
import '../../controllers/home_page_controller.dart';
import '../../widgets/bigtext.dart';
import 'components/appbar.dart';
import 'components/figure_card_widget.dart';
import 'components/main_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<HomePageController>().getInfoList();
    Get.find<DetailPageController>().getVideoList();

    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: EdgeInsets.only(left: D.w20, right: D.w20, top: D.h10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppMethod.firstHeadingMethod,
            //
            MainCardWidget(),
            FigureCardWidget(),

            BigText(
              text: 'Area of focus',
              fontSize: D.f25,
              isFontWeight: true,
              isLessFontWeight: true,
            ),
            SizedBox(height: D.h10),
            Expanded(
              child: GetBuilder<HomePageController>(
                builder: (_homePageController) {
                  return _homePageController.isLoded
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: D.h15,
                            crossAxisSpacing: D.w15,
                          ),
                          itemCount: _homePageController.infoList.length,
                          itemBuilder: (_, index) {
                            final _infomodel =
                                _homePageController.infoList[index];
                            return Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.only(bottom: D.p10 / 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(D.w10),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.gradientSecond
                                          .withOpacity(0.1),
                                      offset: Offset(0, -2),
                                      blurRadius: 3),
                                  BoxShadow(
                                      color: AppColor.gradientSecond
                                          .withOpacity(0.1),
                                      offset: Offset(5, 5),
                                      blurRadius: 3)
                                ],
                                image: DecorationImage(
                                  image: AssetImage(_infomodel.img!),
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              child: BigText(
                                text: _infomodel.title,
                                textColor: AppColor.homePageDetail,
                                fontSize: D.f20,
                              ),
                            );
                          },
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
