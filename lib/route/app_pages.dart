import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:getx_api_call/binding/home_page_binding.dart';
import 'package:getx_api_call/home/view/product2_page.dart';
import 'package:getx_api_call/home/view/product_page.dart';
import 'package:getx_api_call/route/app_routes.dart';

import '../home/view/home_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.initial,
      binding: HomePageBinding(),
      page: () =>  HomePage(),
    ),
    GetPage(
      name: Routes.productPage,
      binding: HomePageBinding(),
      page: () => const ProductPage(),
    ),
    GetPage(
      name: Routes.product2Page,
      binding: HomePageBinding(),
      page: () => const Product2Page(),
    )
  ];
}
