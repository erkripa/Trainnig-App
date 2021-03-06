import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training/models/video_model.dart';
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
  Future<void> onRefresh() async {
    await Get.find<DetailPageController>().initvideolist();
  }

  @override
  Widget build(BuildContext context) {
    print('isLandscape' + MediaQuery.of(context).orientation.toString());
    bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: GetBuilder<DetailPageController>(
        builder: (_detailPageController) {
          return !_isLandscape
              ? Container(
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
                                        child: RefreshIndicator(
                                          onRefresh: onRefresh,
                                          child:
                                              FutureBuilder<List<VideoModel>>(
                                            future: _detailPageController
                                                .futureOfVideoList,
                                            builder: (context,
                                                AsyncSnapshot<List<VideoModel>?>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Center(
                                                  child: BigText(
                                                    text: snapshot.error
                                                        .toString(),
                                                  ),
                                                );
                                              }

                                              if (snapshot.hasData) {
                                                if (snapshot.data!.length > 0) {
                                                  return ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      itemCount:
                                                          snapshot.data!.length,
                                                      itemBuilder: (_, index) {
                                                        final videoModel =
                                                            snapshot
                                                                .data![index];

                                                        return VideoCardListTile(
                                                          onTap: () {
                                                            _detailPageController
                                                                .videoInitialized(
                                                                    index);
                                                            _detailPageController
                                                                .changePlayArea();
                                                          },
                                                          title:
                                                              videoModel.title,
                                                          thumbnail: videoModel
                                                              .thumbnail,
                                                          time: videoModel.time,
                                                          videoUrl: videoModel
                                                              .videoUrl,
                                                        );
                                                      });
                                                } else {
                                                  return Center(
                                                    child: BigText(
                                                      text:
                                                          "!! Your Database is now empty !!",
                                                      textColor: AppColor
                                                          .gradientSecond,
                                                      isFontWeight: true,
                                                      isLessFontWeight: true,
                                                      fontSize: D.f20,
                                                    ),
                                                  );
                                                }
                                              }

                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin:
                                            EdgeInsets.only(top: D.sHeight / 4),
                                        child: CircularProgressIndicator()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: BigText(
                  text:
                      "Right Now Landscape is not Supportable!\nWe will implement this feature very soon..",
                  textColor: AppColor.gradientFirst,
                  fontSize: D.f25,
                ));
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.find<DetailPageController>().setPlayArea = false;
    Get.find<DetailPageController>().videPlayController?.dispose();
    super.dispose();
  }

  Widget _videoPlayView(DetailPageController _detailPageController) {
    final controller = _detailPageController.videPlayController;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
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
      padding: EdgeInsets.only(top: D.p10 / 3, left: D.w10, right: D.w10),
      child: Column(
        children: [
          SizedBox(height: D.h10),
          BigText(
            text: detailPageController.videoTitle,
            textColor: AppColor.secondPageIconColor,
            isFontWeight: true,
          ),
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
                    isFontWeight: true,
                    isLessFontWeight: true,
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
