import 'package:getx_api_call/network/end_point.dart';
import 'package:getx_api_call/network/rest_client.dart';

class ProductRepository {
  Future<dynamic> fatchProducts() async {
    final res = await RestClient.dev().get(
      APIType.PUBLIC,
      API.products,
    );
    return res.data;
  }
}
