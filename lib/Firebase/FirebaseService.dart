import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get userCollectionRefrence =>
      firestore.collection('User');

  CollectionReference get wishlistCollectionRefrence =>
      firestore.collection('Wishlist');

  // add

  Future<void> addWishListCollection(Products products) async {
    final userId = await getUserId();

    await firestore
        .collection('user')
        .doc(userId.toString())
        .firestore
        .collection('Wishlist')
        .doc(products.id.toString())
        .set(products.toMap());

    // await wishlistCollectionRefrence.add(products.toMap());
  }

  //get

  Future<String> getUserId() async {
    UserModel? user = await SecureStorageHelper.instance.getUserDetails();
    if (user == null) {
      throw Exception("User not logged in");
    }
    print("User Id ${user.id.toString()}");

    return user.id.toString();
  }

  Future<List<Products>> getwishlist() async {
    /*final data = await wishlistCollectionRefrence.get();
    return data.docs.map((doc) => Products.fromDoc(doc)).toList();*/

    final userid = await getUserId();
    final data = await firestore
        .collection('user')
        .doc(userid)
        .firestore
        .collection('Wishlist')
        .get();
    return data.docs.map((doc) => Products.fromDoc(doc)).toList();
  }

  // delete

  Future<void> deleteUser(String id) async {
    final user = await SecureStorageHelper.instance.getUserDetails();

    /*await firestore
        .collection('user')
        .doc(user!.id.toString())
        .collection('Wishlist')
        .doc(id)
        .delete();*/
    await wishlistCollectionRefrence.doc(id).delete();

    getwishlist();
  }

  Future<bool> isProductInWishlist(String productId) async {
    final user = await SecureStorageHelper.instance.getUserDetails();

    final doc = await FirebaseFirestore.instance
      /*  .collection('user')
        .doc(user!.id.toString())*/
        .collection('Wishlist')
        .doc(productId)
        .get();

    return doc.exists;
  }
}
