import 'dart:convert';

import 'package:e_commerce_app/Model/TabBar/Home/Products.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

 class AppStorage {
  static late SharedPreferences sharedPreferences;

  static String _isLoggedIn = "is_logged_in";
  static String _token = "token";
  static String _email = "email";
  static String _add_Favourite = "Favourite";
  static String _ischecked = "isChecked";
  RxList<String> selectedIds = <String>[].obs;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> savedLogin({required String email}) async {
    await sharedPreferences.setString(_email, email);
    await sharedPreferences.setBool(_isLoggedIn, true);
  }

  static Future<void> logout() async {
    await sharedPreferences.clear();
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


  static bool get isLoggedIn => sharedPreferences.getBool(_isLoggedIn) ?? false;

  static String get token => sharedPreferences.getString(_token) ?? "";

  static String get email => sharedPreferences.getString(_email) ?? "";
}
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

class shared {
  Future<SharedPreferences> get sharedpref async =>
      await SharedPreferences.getInstance();
}
