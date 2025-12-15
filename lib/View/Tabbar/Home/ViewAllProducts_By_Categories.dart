import 'package:e_commerce_app/AppColors.dart';
import 'package:e_commerce_app/Controller/TabBar/ViewAllProducts_By_Categorie_Controller.dart';
import 'package:e_commerce_app/Custom_Functions.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Categories.dart';
import 'package:flutter/material.dart';
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
      appBar: Custom_Functions.getAppbar(
        categoryController.getSelectedCategorieId.value,
      ),
      body: Container(
        height: scrren_height,
        width: scrren_width,

        child: Obx(() {
          print(
            "categoriew lenght is..${categoryController.productList.length}",
          );
          return categoryController.productList.isEmpty &&
                  categoryController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: categoryController.productList.length,
                      itemBuilder: (context, index) {
                        var item = categoryController.productList[index];
                        String imageUrl =
                            (item.images != null &&
                                item.images!.isNotEmpty &&
                                item.images![0].startsWith("http"))
                            ? item.images![0]
                            : "https://via.placeholder.com/150";

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
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

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.tabSelectedColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        /* home_Controller.selectedId.value = item.id
                                    .toString();
                                Get.to(ProductDetail());*/
                                      },
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
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
