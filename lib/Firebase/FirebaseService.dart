import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get userCollectionRefrence =>
      firestore.collection('User');

  static const String WishlistString = "Wishlist";

  //get UserID
  Future<String?> getuserId() async {
    final userId = SecureStorageHelper.instance.get_UserId();
    return userId;
  }

  // add

  Future<void> addWishListCollection(Products products) async {
    final userId = await getuserId();
    print(" adduserID ${userId}");

    await userCollectionRefrence
        .doc(userId.toString())
        .collection(WishlistString)
        .doc(products.id.toString())
        .set(products.toMap());
  }

  Future<List<Products>> getwishlist() async {
    final userid = await getuserId();
    final data = await userCollectionRefrence
        .doc(userid)
        .collection(WishlistString)
        .get();
    print(data.toString());
    return data.docs.map((doc) => Products.fromDoc(doc)).toList();
  }

  // delete

  Future<void> deleteUser(String id) async {
    final user = await getuserId();

    await userCollectionRefrence
        .doc(user)
        .collection(WishlistString)
        .doc(id)
        .delete();

    getwishlist();
  }

  Future<bool> isProductInWishlist(String productId) async {
    final user = await getuserId();

    final doc = await userCollectionRefrence
        .doc(user)
        .collection(WishlistString)
        .doc(productId)
        .get();

    return doc.exists;
  }
}
