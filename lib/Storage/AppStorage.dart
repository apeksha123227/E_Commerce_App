import 'dart:convert';

import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  static String _add_Favourite = "Favourite";
  static String _ischecked = "isChecked";
  RxList<String> selectedIds = <String>[].obs;

  Future<void> logout() async {
    final data = await sharedPreferences;
    await data.clear();
  }

/* static Future add_Favourite(Products model) async {
    List<Products> list = await get_Favourite();
    list.add(model);
    final data = list.map((e) => jsonEncode(e.toJson())).toList();
    await sharedPreferences.setStringList(_add_Favourite, data);
  }

  static Future<List<Products>> get_Favourite() async {
    List<String>? data = await sharedPreferences.getStringList(_add_Favourite);
    return data != null ? (data.map((e) => Products.fromJson(jsonDecode(e))).toList()) : <Products>[];
  }

  static Future<bool> check_Favourite(String id) async {
    List<Products>? data = await get_Favourite();
    for(Products model in  data){
      if(model.id.toString() == id) {
        return true;
      }
    }
    return false;
  }*/


/*class sharedHelper {
  Future<SharedPreferences> get pref  async => await SharedPreferences.getInstance();
  static String p_id = 'productId';

  Future<void> setInt(int data) async {
    final preference = await pref;
    preference.setInt(p_id, data);
  }
  Future<int?> getInt() async{
    final preference = await pref;
    return preference.getInt(p_id);
  }
}*/
}