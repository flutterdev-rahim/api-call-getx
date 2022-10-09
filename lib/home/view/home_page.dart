import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_call/home/controller/product2_controller.dart';
import 'package:getx_api_call/home/repository/product2_repository.dart';
import 'package:getx_api_call/route/app_routes.dart';

class HomePage extends StatelessWidget {
  Product2Controller product2controller = Get.put(
    Product2Controller(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.productPage);
              },
              child: const Text('productPage'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
            
             Get.toNamed(Routes.product2Page);
              print('object');
            },
            child: const Text('product2Page'),
          )
        ],
      ), 
    );
  }
}
