import 'package:get/get.dart';
import 'package:getx_api_call/home/model/product2_model.dart';
import 'package:getx_api_call/home/repository/product2_repository.dart';

class Product2Controller extends GetxController {
  @override
  void onInit() {
    fatchProduct2data();
    // TODO: implement onInit
    super.onInit();
  }

  List<Product2Model> product2List = [];
  List<TagList> tagList = [];
  fatchProduct2data() async {
    final data = await Product2Repository().fatchProduct2apidata();
    product2List = data;
    
    print(product2List);
  }
}
