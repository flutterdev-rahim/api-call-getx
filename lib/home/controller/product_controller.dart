import 'package:get/get.dart';
import 'package:getx_api_call/home/model/product_model.dart';
import 'package:getx_api_call/home/repository/product_repository.dart';
import 'package:getx_api_call/network/logger.dart';
import 'package:getx_api_call/page_state/page_state.dart';

class ProductController extends GetxController {
  ProductRepository productRepository = ProductRepository();

  /// Page State
  final Rx<PageState> _pageStateController = Rx(PageState.initial);

  get pageState => _pageStateController.value;
  @override
  void onInit() {
    fatchProductss();
    // TODO: implement onInit
    super.onInit();
  }

  bool get isLoading => pageState == PageState.loading;
  List<ProductResposeModel> data_list = [];

  ///2nd way
  Future<void> fatchProductss() async {
    _pageStateController(PageState.loading);
    try {
      var res = await productRepository.fatchProducts();
      print('................$res');
      data_list =
          (res as List).map((e) => ProductResposeModel.fromJson(e)).toList();
    } catch (e, stackTrace) {
      Log.error(
        e.toString(),
      );
      Log.error(
        stackTrace.toString(),
      );
      _pageStateController(PageState.error);
      Get.snackbar(
        'Failed',
        'Something went wrong while fetching cart',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _pageStateController(PageState.success);
  }
}
