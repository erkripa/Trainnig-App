import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training/utils/colors.dart';
import 'package:training/utils/dimension.dart';
import 'package:training/widgets/app_icon.dart';
import 'package:training/widgets/bigtext.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/detail_page_controller.dart';
import 'components/methods.dart';
import 'components/video_card_list_tile.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DetailPageController>(
        builder: (_detailPageController) {
          return Container(
            decoration: _detailPageController.playArea
                ? detailNewDecoration
                : detailPageDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailAppBar(),
                !_detailPageController.playArea
                    ? buildFirstHalfSection()
                    : Column(
                        children: [
                          _videoPlayView(_detailPageController),
                          _videoControllBtnView(_detailPageController),
                        ],
                      ),
                //
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: D.h10),
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
                      child: Column(
                        children: [
                          buildHeadinAndIconWithText(),
                          _detailPageController.isLoded
                              ? Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _detailPageController
                                          .videoList.length,
                                      itemBuilder: (_, index) {
                                        final videoModel = _detailPageController
                                            .videoList[index];
                                        return VideoCardListTile(
                                          onTap: () {
                                            _detailPageController
                                                .videoInitialized(index);
                                            _detailPageController
                                                .changePlayArea();
                                          },
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _videoPlayView(DetailPageController _detailPageController) {
    final controller = _detailPageController.videPlayController;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.secondPageIconColor,
          ),
        ),
      );
    }
  }

  Widget _videoControllBtnView(DetailPageController detailPageController) {
    String convertTwo(int value) {
      return value < 10 ? "0$value" : "$value";
    }

    return Container(
      margin: EdgeInsets.only(top: D.p10 / 3),
      child: Column(
        children: [
          
          

          VideoProgressIndicator(
            detailPageController.videPlayController!,
            allowScrubbing: true,
            padding: EdgeInsets.symmetric(horizontal: D.w20, vertical: D.h20),
            colors: VideoProgressColors(
              backgroundColor: Colors.white,
              bufferedColor: Colors.white10,
              playedColor: Colors.red,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                onPressed: detailPageController.onTapVolumBtn,
                icon: detailPageController.noMute
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
                iconColor: AppColor.secondPageIconColor,
                iconSize: D.f25 * 1.3,
              ),
              SizedBox(width: D.w20),
              AppIcon(
                onPressed: detailPageController.onLeftBtnClicked,
                icon: Icons.fast_rewind_rounded,
                iconColor: AppColor.secondPageIconColor,
                iconSize: D.f25 * 1.5,
              ),
              SizedBox(width: D.w20),
              AppIcon(
                onPressed: detailPageController.changePlayBtn,
                icon: detailPageController.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow_rounded,
                iconColor: AppColor.secondPageIconColor,
                iconSize: D.f25 * 1.5,
              ),
              SizedBox(width: D.w20),
              AppIcon(
                onPressed: detailPageController.onRightBtnClicked,
                icon: Icons.fast_forward_rounded,
                iconColor: AppColor.secondPageIconColor,
                iconSize: D.f25 * 1.5,
              ),
              SizedBox(width: D.w20),
              ValueListenableBuilder(
                valueListenable: detailPageController.videPlayController!,
                builder: (context, VideoPlayerValue value, child) {
                  final duration = value.duration.inSeconds;
                  final position = value.position.inSeconds;
                  final head = position;
                  final remained = max(0, duration - head);
                  final mins = convertTwo(remained ~/ 60.0);
                  final secs = convertTwo(remained % 60);

                  return BigText(
                    text: "$mins:$secs",
                    textColor: AppColor.secondPageIconColor.withAlpha(211),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFirstHalfSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDetailPageTitle(),
        buildTwoBtn(),
      ],
    );
  }
}
