import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training/controllers/detail_page_controller.dart';
import 'package:training/routes/app_route.dart';


import 'package:training/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailPageController>(builder: (_) {
      return GetMaterialApp(
        title: 'Traning App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomePage(),
        getPages: AppRoute.routes,
      );
    });
  }
}
