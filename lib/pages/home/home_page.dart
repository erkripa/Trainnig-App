import 'package:flutter/material.dart';
import 'package:video_player_app/pages/home/components/methods.dart';
import 'package:video_player_app/utils/colors.dart';
import 'package:video_player_app/utils/dimension.dart';
import 'package:video_player_app/widgets/app_icon.dart';
import 'package:video_player_app/widgets/smalltext.dart';

import '../../widgets/bigtext.dart';
import 'components/appbar.dart';
import 'components/figure_card_widget.dart';
import 'components/main_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        margin: EdgeInsets.only(left: D.w20, right: D.w20, top: D.h15),
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
            
          ],
        ),
      ),
    );
  }
}
