import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training/utils/colors.dart';
import 'package:training/utils/dimension.dart';
import 'package:training/widgets/bigtext.dart';

import '../../routes/app_route.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? colorAnimation;
  Animation? colorAnimation1;
  Animation<double>? sizeAnimation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    colorAnimation = ColorTween(
            begin: AppColor.circuitsColor, end: AppColor.gradientSecond)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeIn));
    //
    colorAnimation1 = ColorTween(
            begin: AppColor.gradientSecond,
            end: AppColor.homePageBackground.withOpacity(0.2))
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeIn));

    sizeAnimation =
        Tween<double>(begin: D.h10 * 10, end: D.h15 * 12).animate(controller!);
    controller!.addListener(() {
      setState(() {});
    });
    Timer(Duration(seconds: 4), () => Get.toNamed(AppRoute.getInitialPage()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        // height: D.sHeight,
        // height: sizeAnimation!.value,
        // width: sizeAnimation!.value,
        color: colorAnimation!.value,

        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: D.w10 * 5,
                // width: D.w10 * 5,
                height: sizeAnimation!.value / 3,
                width: sizeAnimation!.value / 3,
                margin:
                    EdgeInsets.only(left: D.w5, top: sizeAnimation!.value / 5),
                decoration: BoxDecoration(
                    color: colorAnimation1!.value,
                    image:
                        DecorationImage(image: AssetImage('assets/1024.png')),
                    borderRadius: BorderRadius.circular(D.w10)),
              ),
              Center(
                child: Image.asset(
                  'assets/splash1.png',
                  height: D.sHeight / 1.5,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  colorBlendMode: BlendMode.darken,
                  // opacity: sizeAnimation,
                  scale: 1.0,
                ),
              ),
              SizedBox(height: D.h20),
              Center(
                child: Container(
                  color: colorAnimation!.value,
                  child: BigText(
                    text: 'Welcome To Yoga Training',
                    textColor: AppColor.secondPageIconColor,
                    isFontWeight: true,
                    fontSize: D.f25,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
