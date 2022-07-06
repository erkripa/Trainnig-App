import 'package:get/get.dart';
import 'package:training/pages/details/datail_page.dart';
import 'package:training/pages/home/home_page.dart';
import 'package:training/pages/splash/splash_page.dart';

class AppRoute {
  static const _splash = '/';
  static const _initial = '/home';
  static const _detail = '/detail';

  static String getSplashPage() => '$_splash';
  static String getInitialPage() => '$_initial';
  static String getDetailPage() => '$_detail';

  static List<GetPage> routes = [
    GetPage(
      name: _splash,
      page: () => SplashPage(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: _initial,
      page: () => HomePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _detail,
      page: () => DetailPage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
