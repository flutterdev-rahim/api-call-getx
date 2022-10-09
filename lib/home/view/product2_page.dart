import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_call/home/controller/product2_controller.dart';
import 'package:getx_api_call/home/model/product2_model.dart';

class Product2Page extends GetView<Product2Controller> {
  const Product2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: controller.product2List.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            String name = controller.product2List[index].name ?? '';
            String description =
                controller.product2List[index].description ?? '';
            List<TagList> taglist = controller.product2List[index].tagList!;
            return Card(
              child: ListTile(
                title: Text(name),
                subtitle: Column(
                  children: [
                      Text(description),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: taglist.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, indexs) {
                        return Column(
                          children: [
                          
                            Text(taglist[indexs].name),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
