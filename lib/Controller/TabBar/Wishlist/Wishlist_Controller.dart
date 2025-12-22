import 'package:e_commerce_app/Controller/TabBar/Home/Product_Detail_Controller.dart';
import 'package:e_commerce_app/Firebase/FirebaseService.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';

class Wishlist_Controller extends GetxController {
  RxList<Products> wishlist = <Products>[].obs;
  RxBool isLoading = false.obs;


  // final productController = Get.find<Product_Detail_Controller>();
  final FirebaseService service = FirebaseService();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadWishlist();
  }

  Future<void> loadWishlist() async {
    isLoading.value = true;
    wishlist.value = await service.getwishlist();
    isLoading.value = false;
  }

  Future<void> removefrowishlist(String id,int index) async {
    await service.deleteUser(id);
    wishlist.removeAt(index);
  }


}
