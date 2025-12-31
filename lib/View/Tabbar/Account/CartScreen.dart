import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/CartController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Cartscreen extends StatelessWidget {
  Cartscreen({super.key});

  final cart_Controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Custom_Functions.getAppbar("Your Cart"),
      body: Container(
        height: scrren_height,
        width: scrren_width,
        child: Column(
          children: [
            Divider(thickness: 0.4, color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Custom_Functions.getTextStyle_16_blackTxt(
                      "Delivery to",
                    ),
                  ),

                  Custom_Functions.getTextStyle_16_blackTxt("Your Address "),
                ],
              ),
            ),
            Divider(thickness: 0.4, color: Colors.grey.shade300),
            Expanded(
              child: Obx(() {
                return cart_Controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : cart_Controller.cartlist.isEmpty
                    ? const Center(child: Text("Your cart is empty"))
                    : RefreshIndicator(
                        onRefresh: () async =>
                            await cart_Controller.loadCartList(),

                        child: ListView.builder(
                          itemCount: cart_Controller.cartlist.length,
                          itemBuilder: (context, index) {
                            final item = cart_Controller.cartlist[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("Cart Id ${item.id.toString()}");
                                      Get.to(
                                        ProductDetail(),
                                        arguments: {"ID": item.id},
                                      );
                                    },
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          item.images![0],
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/images/placholder.png",
                                                  fit: BoxFit.fill,
                                                );
                                              },
                                        ),
                                      ),
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
                                              color:
                                                  AppColors.tabUnselectedColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Expanded(
                                                child:
                                                    Custom_Functions.getTextStyle_16_blackTxt(
                                                      item!.price.toString(),
                                                      fontweight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  cart_Controller.decrement(
                                                    item.id!,
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 0.6, // lite stroke
                                                    ),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/images/delete.svg",
                                                    height: 17,
                                                    width: 17,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Custom_Functions.getTextStyle_16_blackTxt(
                                                item.quantity.toString(),
                                              ),
                                              SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  cart_Controller.increment(
                                                    item.id!,
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 0.6, // lite stroke
                                                    ),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/images/delete.svg",
                                                    height: 17,
                                                    width: 17,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              //  if (item.quantity == 1)
                                              InkWell(
                                                onTap: () {
                                                  cart_Controller
                                                      .removeFromCart(
                                                        item.id.toString(),
                                                        index,
                                                      );
                                                  Get.snackbar(
                                                    '',
                                                    ' Successfully Deleted',
                                                  );
                                                },

                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 0.6, // lite stroke
                                                    ),
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/images/delete.svg",
                                                    height: 17,
                                                    width: 17,
                                                    color: AppColors
                                                        .tabUnselectedColor,
                                                  ),
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
                            );
                          },
                        ),
                      );
              }),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.tabSelectedColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: AppColors.LightGreyText,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buyNowCOlor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: AppColors.LightGreyText,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                              color: AppColors.blackText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
