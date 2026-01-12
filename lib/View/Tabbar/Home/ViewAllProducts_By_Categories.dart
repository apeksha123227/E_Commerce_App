import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/ViewAllProducts_By_Categorie_Controller.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:e_commerce_app/View/Tabbar/Account/CartScreen.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

class ViewAllProducts_By_Categorie extends StatelessWidget {
  const ViewAllProducts_By_Categorie({super.key});

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    final categoryController = Get.put(
      ViewAllProducts_By_Categorie_Controller(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            "${categoryController.getselectedName.value}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        leading: InkWell(
          onTap: Get.back,
          child: Center(
            child: SvgPicture.asset(
              "assets/images/back.svg",
              height: 30,
              width: 30,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: /*SvgPicture.asset("assets/images/cart.svg"),*/ Stack(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(Cartscreen());
                  },
                  child: SvgPicture.asset("assets/images/cart.svg"),
                ),
                if (categoryController.cartController.cartlist.length > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Obx(() {
                        return Text(
                          '${categoryController.cartController.cartlist.length}',

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      body: Container(
        /* height: scrren_height,
        width: scrren_width,*/
        child: Obx(() {
          print(
            "categoriew lenght is..${categoryController.productList.length}",
          );
          return categoryController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : categoryController.productList.isEmpty
              ? Center(child: Text("No Data Found"))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,

                      //  physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        // mainAxisSpacing: 10,
                        childAspectRatio: 9 / 14.4,
                      ),
                      itemCount: categoryController.productList.length,
                      itemBuilder: (context, index) {
                        var item = categoryController.productList[index];
                        /* String imageUrl =
                            (item.images != null &&
                                item.images!.isNotEmpty &&
                                item.images![0].startsWith("http"))
                            ? item.images![0]
                            : "https://via.placeholder.com/150";*/

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // IMAGE
                            InkWell(
                              onTap: () {
                                print("id ${item.id}");
                                Get.to(
                                  ProductDetail(),
                                  arguments: {"ID": item.id.toString()},
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  item.images![0] ?? "",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/placholder.png",
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? "No Title",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.blackText,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    "₹ ${item.price}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Obx(() {
                                    final isInCart = categoryController.isInCart(
                                      item.id.toString(),
                                    );

                                    return SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.tabSelectedColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),

                                        onPressed: () {
                                          if (isInCart) {
                                            categoryController.removeFromCart(
                                              item.id.toString(),
                                            );
                                            Get.snackbar(
                                              "Item Remove ",
                                              "Successfully Remove to your cart",
                                              snackPosition: SnackPosition.BOTTOM,
                                            );
                                          } else {
                                            categoryController.addToCart(item);
                                            Get.snackbar(
                                              "Item Added",
                                              "Successfully added to your cart",
                                              snackPosition: SnackPosition.BOTTOM,
                                            );
                                          }
                                        },
                                        child: Text(
                                          isInCart ? "Remove" : "Add to Cart",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
