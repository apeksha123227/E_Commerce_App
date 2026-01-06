import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/Account/CartController.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/Product_Detail_Controller.dart';
import 'package:e_commerce_app/Controller/TabBar/Home/HomeController.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/View/Tabbar/Account/CartScreen.dart';
import 'package:e_commerce_app/View/Tabbar/Home/AllCategories.dart';
import 'package:e_commerce_app/View/Tabbar/Home/Product_Detail.dart';
import 'package:e_commerce_app/View/Tabbar/Home/ViewAllProducts_By_Categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final home_Controller = Get.find<HomeController>();
  final CartController cartController = Get.put(CartController());

  //final home_Controller = Get.put(HomeController);

  @override
  Widget build(BuildContext context) {
    final scrren_width = MediaQuery.of(context).size.width;
    final scrren_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //   physics: NeverScrollableScrollPhysics(),
          child: Container(
            child: /* home_Controller.isLoading.value?Center(child: CircularProgressIndicator()):*/
                /*   if(home_Controller.isLoading.value && home_Controller.categoryList.isEmpty &&
                home_Controller.isLoading.value)...[*/
                Obx(() {
                  if (home_Controller
                      .isLoading
                      .value /* &&
                    home_Controller.categoryList.isEmpty*/ ) {
                    return Container(
                      height: scrren_height,
                      width: scrren_width,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery address",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.LightGreyText,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Obx(() {
                                      return Text(
                                        "${home_Controller.address.value}",
                                        style: TextStyle(
                                          color: AppColors.blackText,
                                          fontSize: 13,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Stack(
                                children: [
                                  InkWell(
                                      onTap:(){
                                        Get.to(Cartscreen());
                                      },
                                      child: SvgPicture.asset("assets/images/cart.svg")),
                                  if ( /*home_Controller
                                          .*/ cartController.cartlist.length >
                                      0)
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
                                            '${ /*home_Controller.*/ cartController.cartlist.length}',
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
                              SizedBox(width: 15),
                              SvgPicture.asset(
                                'assets/images/Notification.svg',
                                width: 22,
                                height: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: home_Controller.searchController,
                            cursorColor: AppColors.tabUnselectedColor,
                            decoration: InputDecoration(
                              hintText: "Search here...",
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.tabUnselectedColor,
                              ),
                              suffixIcon: Obx(() {
                                return home_Controller.showClearIcon.value
                                    ? IconButton(
                                        onPressed: () {
                                          home_Controller.searchController
                                              .clear();
                                          home_Controller.showClearIcon.value =
                                              false;
                                          home_Controller
                                              .searchProductsAndCategories("");
                                        },
                                        icon: SvgPicture.asset(
                                          "assets/images/close.svg",
                                          height: 11,
                                          width: 11,
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }),

                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color:
                                    AppColors.LightGreyText, // hint text color
                              ),
                            ),
                            style: TextStyle(
                              color: AppColors.tabUnselectedColor,
                              fontSize: 15, // text color
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() {
                        return SizedBox(
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: home_Controller.bannerList.length,
                              itemBuilder: (context, index) {
                                final item = home_Controller.bannerList[index];
                                return Container(
                                  width: 260,
                                  margin: EdgeInsets.only(right: 3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(item, fit: BoxFit.fill),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),

                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Custom_Functions.getTextStyle_16_blackTxt(
                          "Category",
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return /*home_Controller.categoryList.isEmpty &&
                              home_Controller.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : */ Expanded(
                                child: SizedBox(
                                  height: 80,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        home_Controller
                                                .filteredCategories
                                                .length >
                                            5
                                        ? 6
                                        : home_Controller
                                              .filteredCategories
                                              .length,
                                    itemBuilder: (context, index) {
                                      if (home_Controller
                                                  .filteredCategories
                                                  .length >
                                              5 &&
                                          index == 5) {
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  Get.to(AllCategories()),
                                              child: SvgPicture.asset(
                                                'assets/images/All.svg',
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                            Text(
                                              "All",
                                              style: TextStyle(
                                                color: AppColors
                                                    .tabUnselectedColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      final item = home_Controller
                                          .filteredCategories[index];

                                      /* String imageUrl =
                                                  (item.image != null &&
                                                      item.image!.isNotEmpty &&
                                                      item.image!.startsWith(
                                                        "http",
                                                      ))
                                                  ? item.image!
                                                  : "https://via.placeholder.com/150";*/

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              /* home_Controller
                                                          .selectedCategoriesId
                                                          .value = item.id
                                                          .toString();*/
                                              home_Controller
                                                  .selectedCatName
                                                  .value = item.name
                                                  .toString();
                                              Get.to(
                                                ViewAllProducts_By_Categorie(),
                                                arguments: {
                                                  "CategoriesID": item.id
                                                      .toString(),
                                                  "CategoriesName": item.name
                                                      .toString(),
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              margin: EdgeInsets.only(
                                                right: 15,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  item.image ?? "",
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
                                          ),
                                          SizedBox(height: 5),

                                          SizedBox(
                                            width: 50,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              item.name!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: AppColors
                                                    .tabUnselectedColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Custom_Functions.getTextStyle_16_blackTxt(
                              "Recent product",
                              fontweight: FontWeight.bold,
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Custom_Functions.getTextStyle_16_blackTxt(
                                  "Filters",
                                ),
                                SizedBox(width: 15),
                                SvgPicture.asset(
                                  'assets/images/Filter.svg',
                                  width: 15,
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GridForProdcut(),
                      //SizedBox(height: 10),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Obx GridForProdcut() {
    return Obx(() {
      /*  if (home_Controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
*/
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: home_Controller.filteredProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            //mainAxisSpacing: 5,
            childAspectRatio: 9 / 14.4,
          ),
          itemBuilder: (context, index) {
            var item = home_Controller.filteredProducts[index];
           /* final inCart = Custom_Functions().isInCart(item.id.toString());
            if (inCart == true) {
              home_Controller.txtadded.value = "Added";
            } else {
              home_Controller.txtadded.value = "Add to Cart";
            }*/

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE
                InkWell(
                  onTap: () {
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
                      SizedBox(
                        width: 150,
                        child: Text(
                          item.title ?? "No Title",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.blackText,
                          ),
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

                      FutureBuilder<bool>(
                        future: Custom_Functions().isInCart(item.id.toString()),
                        builder: (contex, snapshot) {
                          final isIncart = snapshot.data ?? false;
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.tabSelectedColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),

                              onPressed: () async {
                                //home_Controller.txtadded.value = "Add to cart";
                                /*final inCart = Custom_Functions().isInCart(
                                productId.toString(),
                              );*/
                                if ( isIncart) {
                                  //home_Controller.txtadded.value = "Added";
                                  Get.snackbar(
                                    "Already in Cart",
                                    "This product is already added",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } else {
                                  Get.snackbar(
                                    "Item Added",
                                    "SuccessFully Added in your cart",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                  await Custom_Functions().addtoCart(
                                    item,
                                    home_Controller.selectedIndex.value,
                                  );
                                }
                              },
                              child: Text(
                                isIncart?"Added":"Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
