import 'package:get/get.dart';
import 'package:training/controllers/detail_page_controller.dart';
import 'package:training/controllers/home_page_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => HomePageController());
  Get.lazyPut(() => DetailPageController(), fenix: true);
}
