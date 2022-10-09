import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:getx_api_call/home/controller/product2_controller.dart';
import 'package:getx_api_call/home/controller/product_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => Product2Controller(), fenix: true);
  }
}
