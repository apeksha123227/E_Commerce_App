import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/Product_Detail_Controller.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Storage/AppStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;
    final product_Detail_Controller = Get.put(Product_Detail_Controller());

    return Scaffold(
      appBar: Custom_Functions.getAppbar("Details product"),
      body: Container(
        height: scrren_height,
        width: scrren_width,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Obx(() {
                    if (product_Detail_Controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final item =
                        product_Detail_Controller.productsDetails.value;
                    // String selectedImg = product_Detail_Controller.imageSelectedId.value;

                    if (item == null) {
                      return Center(child: Text("No product found"));
                    }

                    return product_Detail_Controller.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.images != null &&
                                  item.images!.isNotEmpty) ...[
                                Obx(() {
                                  return SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    child: Image.network(
                                      item.images![product_Detail_Controller
                                          .selectedIndex
                                          .value],
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Image.asset(
                                              "assets/images/placholder.png",
                                              fit: BoxFit.fill,
                                            );
                                          },
                                    ),
                                  );
                                }),
                                SizedBox(height: 10),
                                Obx(() {
                                  if (product_Detail_Controller
                                      .isLoading
                                      .value) {
                                    return CircularProgressIndicator();
                                  }
                                  var item = product_Detail_Controller
                                      .productsDetails
                                      .value;
                                  var imageList = item?.images ?? [];

                                  // String selectedImg = product_Detail_Controller
                                  //     .imageSelectedId
                                  //     .value;

                                  return SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imageList.length,
                                        itemBuilder: (context, index) {
                                          // String img = imageList[index];
                                          bool isSelected =
                                              product_Detail_Controller
                                                  .selectedIndex
                                                  .value ==
                                              index;

                                          return InkWell(
                                            onTap: () {
                                              product_Detail_Controller
                                                      .selectedIndex
                                                      .value =
                                                  index;
                                              // Get.appUpdate();
                                              /* ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(content: Text(img)),
                                            );*/
                                            },
                                            child: Obx(() {
                                              return Container(
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color:
                                                        product_Detail_Controller
                                                                .selectedIndex
                                                                .value ==
                                                            index
                                                        ? Colors.green
                                                        : Colors.transparent,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    child: Image.network(
                                                      imageList[index],
                                                      fit: BoxFit.fill,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) {
                                                            return Image.asset(
                                                              "assets/images/placholder.png",
                                                              fit: BoxFit.fill,
                                                            );
                                                          },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }),
                              ],

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 25,
                                                ),
                                                child:
                                                    Custom_Functions.getTextStyle_16_blackTxt(
                                                      "${item!.title ?? ""}",
                                                      fontweight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                "₹ ${item!.price ?? ""}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 19,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Obx(() {
                                          return InkWell(
                                            onTap: () {
                                              final item =
                                                  product_Detail_Controller
                                                      .productsDetails
                                                      .value;
                                              if (product_Detail_Controller
                                                  .isChecked
                                                  .value) {
                                                product_Detail_Controller
                                                    .removefrowishlist(
                                                      item!.id.toString(),
                                                    );
                                              } else {
                                                product_Detail_Controller
                                                    .addWishList();
                                              }
                                              /* product_Detail_Controller
                                            .isChecked
                                            .value =
                                        !product_Detail_Controller
                                            .isChecked
                                            .value;*/
                                            },
                                            child: SvgPicture.asset(
                                              product_Detail_Controller
                                                      .isChecked
                                                      .value
                                                  ? "assets/images/wishlistRed.svg"
                                                  : "assets/images/wishlist.svg",
                                            ),
                                          );
                                        }),
                                      ],
                                    ),

                                    SizedBox(height: 10),
                                    Obx(() {
                                      var item = product_Detail_Controller
                                          .productsDetails
                                          .value;
                                      String? categoryImage =
                                          item?.category?.image;
                                      return Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 27,
                                            backgroundImage:
                                                categoryImage != null
                                                ? NetworkImage(categoryImage)
                                                : null,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Text(
                                              "${item!.category!.name ?? ""}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 19,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color:
                                                      AppColors.LightGreyText,
                                                  // Border color
                                                  width: 0.5, // Border width
                                                ), // Rounded corners
                                              ),
                                            ),
                                            child:
                                                Custom_Functions.getTextStyle_16_blackTxt(
                                                  "Follow",
                                                  fontweight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      );
                                    }),
                                    SizedBox(height: 13),
                                    Custom_Functions.getTextStyle_16_blackTxt(
                                      "Description of product",
                                      fontweight: FontWeight.bold,
                                    ),
                                    SizedBox(height: 13),
                                    Obx(() {
                                      var item = product_Detail_Controller
                                          .productsDetails
                                          .value;
                                      return Text(
                                        "${item!.description!}",
                                        style: TextStyle(
                                          color: AppColors.blackText,
                                          fontSize: 14,
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          );
                  }),
                ),
              ),
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
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
