import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Cart/CartController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class History extends StatelessWidget {
  History({super.key});

  final cart_Controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Custom_Functions.getAppbar("Cart product"),
      body: Container(
        height: scrren_height,
        width: scrren_width,
        child: Obx(() {
          return cart_Controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : cart_Controller.cartlist.isEmpty
              ? const Center(child: Text("Your cart is empty"))
              : RefreshIndicator(
                  onRefresh: () async => await cart_Controller.loadCartList(),

                  child: ListView.builder(
                    itemCount: cart_Controller.cartlist.length,
                    itemBuilder: (context, index) {
                      final item = cart_Controller.cartlist[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            print("Cart Id ${item.id.toString()}");
                            Get.to(ProductDetail(), arguments: {"ID": item.id});
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                  item.images![0],
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/placholder.png",
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Custom_Functions.getTextStyle_16_blackTxt(
                                        item!.title ?? "",
                                        fontweight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        item.categoryName ?? "",
                                        style: TextStyle(
                                          color: AppColors.tabUnselectedColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Custom_Functions.getTextStyle_16_blackTxt(
                                            item!.price.toString(),
                                            fontweight: FontWeight.bold,
                                          ),
                                          Spacer(),

                                          Text(
                                            "Remove",
                                            style: TextStyle(
                                              color: AppColors.tabSelectedColor,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              /* cart_Controller
                                            .removefrowishlist(
                                          item.id.toString(),
                                          index,
                                        );*/
                                            },
                                            child: Icon(
                                              Icons.cancel,
                                              color: AppColors.tabSelectedColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        }),
      ),
    );
  }
}
