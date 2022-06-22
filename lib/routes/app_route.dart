import 'package:get/get.dart';
import 'package:training/pages/details/datail_page.dart';
import 'package:training/pages/home/home_page.dart';

class AppRoute {
  static const _initial = '/';
  static const _detail = '/detail';

  static String getInitialPage() => '$_initial';
  static String getDetailPage() => '$_detail';

  static List<GetPage> routes = [
    GetPage(
      name: _initial,
      page: () => HomePage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _detail,
      page: () => DetailPage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
