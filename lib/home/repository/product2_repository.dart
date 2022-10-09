import 'package:getx_api_call/home/model/product2_model.dart';

import 'package:http/http.dart' as http;

class Product2Repository {
  Future<List<Product2Model>> fatchProduct2apidata() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://makeup-api.herokuapp.com/api/v1/products.json?brand=marienatie'),
    );
    print(response.body);
    try {
      if (response.statusCode == 200) {
        return product2ModelFromJson(response.body);
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }

    return product2ModelFromJson(response.body);
  }
}
