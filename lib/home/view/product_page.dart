import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_api_call/home/controller/product_controller.dart';
import 'package:getx_api_call/home/model/product_model.dart';
import 'package:getx_api_call/page_state/page_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productProvider = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    List men = productProvider.data_list
        .where(
          (element) => element.category == 'men\'s clothing',
        )
        .toList();
    List<ProductResposeModel> women = productProvider.data_list
        .where((element) => element.category == 'women\'s clothing')
        .toList();
    List jewelery = productProvider.data_list
        .where((element) => element.category == 'jewelery')
        .toList();
    List electrics = productProvider.data_list
        .where((element) => element.category == 'electronics')
        .toList();

    // print('women ${data}');
    // print('women ${data.length}');
    // print(data[0]['title']);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey,
            elevation: 0,
            title: const Text("BPPSHOP "),
            actions: const [
              // MaterialButton(
              //     onPressed: () {
              //       signOut();

              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => LoginPage()));
              //     },
              //     child: Container(
              //       color: Colors.blueGrey,
              //       padding: EdgeInsets.all(10),
              //       child: Text('SignOut'),
              //     )),
              // IconButton(
              //     onPressed: () {
              //       signOut();

              //       Navigator.pop(context);
              //     },
              //     icon: Icon(Icons.delete))
            ],
          ),
          body: Obx(() {
            if (productProvider.pageState == PageState.loading) {
              // return LoadingIndicator.list().paddingSymmetric(horizontal: 20);
            }
            if (productProvider.pageState == PageState.error) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(top: 20),
                  width: 250,
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search,
                        size: 50,
                      ),
                      Text(
                        'No detail is found',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      // isScrollable: true,
                      indicator: BoxDecoration(
                        color: const Color.fromRGBO(102, 117, 102, 1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Men'),
                        Tab(text: 'Jewelery'),
                        Tab(text: 'Women'),
                        Tab(text: 'Electics'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            StaggeredGridView.countBuilder(
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.count(
                                        2, index.isEven ? 2 : 1),
                                mainAxisSpacing: 1.0,
                                crossAxisSpacing: 1.0,
                                crossAxisCount: 4,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productProvider.data_list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      var id =
                                          productProvider.data_list[index].id;
                                      var price = productProvider
                                          .data_list[index].price;
                                      // var name = productProvider.data_list[index]
                                      //     ['title'];
                                      // var details = productProvider
                                      //     .data_list[index]['description'];
                                      // var image = productProvider.data_list[index]
                                      //     ['image'];
                                      // print(price);
                                      //print(id);

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: ((context) =>
                                      //             ProductsDetails(
                                      //               productPrice: productProvider
                                      //                       .data_list[index]
                                      //                   ['price'],
                                      //               productName: productProvider
                                      //                       .data_list[index]
                                      //                   ['title'],
                                      //               products_details:
                                      //                   productProvider
                                      //                           .data_list[index]
                                      //                       ['description'],
                                      //               productsImage: productProvider
                                      //                       .data_list[index]
                                      //                   ['image'],
                                      //             ))));
                                    },
                                    child: Container(
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Image.network(
                                                  productProvider
                                                      .data_list[index].image
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              productProvider
                                                  .data_list[index].title
                                                  .toString(),
                                              maxLines: 1,
                                              style: const TextStyle(),
                                            ),
                                            Text(
                                              'Price ${productProvider.data_list[index].rating?.rate.toString()}',
                                              style: const TextStyle(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                itemCount: men.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) {
                                  // men.sort((a, b) => a['price'].compareTo(b['price']));
                                  // for (var p in men) {
                                  //  // print(p['price']);
                                  // }
                                  return Card(
                                      child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Image.network(men[index]
                                                    ['image']
                                                .toString())),
                                      ),
                                      Text(
                                        men[index]['title'].toString(),
                                        style: const TextStyle(),
                                      ),
                                      Text(
                                        'Price ${men[index]['price'].toString()}',
                                        style: const TextStyle(),
                                      )
                                    ],
                                  ));
                                })
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: GridView.builder(
                            itemCount: jewelery.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Expanded(
                                      child: Image.network(
                                          jewelery[index]['image'].toString()),
                                    )),
                                    Text(jewelery[index]['title'].toString()),
                                    Text(
                                      'Price ${jewelery[index]['price'].toString()}',
                                      style: const TextStyle(),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                itemCount: women.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              child: Image.network(women[index]
                                                  .image
                                                  .toString())),
                                        ),
                                        Text(women[index].title.toString()),
                                        Text(
                                          'Price ${women[index].rating!.rate.toString()}',
                                          style: const TextStyle(),
                                        )
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                itemCount: electrics.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              child: Image.network(
                                                  electrics[index]['image']
                                                      .toString())),
                                        ),
                                        Text(electrics[index]['title']
                                            .toString()),
                                        Text(
                                          'Price ${electrics[index]['price'].toString()}',
                                          style: const TextStyle(),
                                        )
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            );
          })),
    );
  }
}

// 
