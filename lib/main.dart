import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_api_call/route/app_pages.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [RouteObserver<ModalRoute<void>>()],
      title: 'Admission Assistant',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
    );
  }
}
