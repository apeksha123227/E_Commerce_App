import 'dart:convert';

import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();

  static final SecureStorageHelper instance = SecureStorageHelper._();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // static const String tokenKey = 'auth_token';
  static const String _accessTokenKey = "access";
  static const String _refreshTokenKey = "refresh";
  static const String _UserData = "userDetails";
  static const String _UserID = "userID";

  //save Token

  Future<void> save_Token({
    required String accesstoken,
    // required String refreshtoken,
  }) async {
    await storage.write(key: _accessTokenKey, value: accesstoken);
    //  await storage.write(key: _refreshTokenKey, value: refreshtoken);
  }


  Future<void> save_UserId({required String userid}) async {
    await storage.write(key: _UserID, value: userid);
    //  await storage.write(key: _refreshTokenKey, value: refreshtoken);
  }

  //get token

  Future<String?> get_AccessToken() async {
    final data = await storage.read(key: _accessTokenKey);
    return data;
  }

   Future<String?> get_UserId() async {
    final data = await storage.read(key: _UserID);
    return data;
  }

  Future<String?> get_RefreshToken() async {
    final data = await storage.read(key: _refreshTokenKey);
    return data;
  }

  //delete token

  Future<void> delete_Token() async {
    await storage.delete(key: _accessTokenKey);
  }

  //delete all for logout

  Future<void> delete_all() async {
    await storage.deleteAll();
  }

  //save User

  Future<void> saveUserDetails(UserModel user) async {
    await storage.write(key: _UserData, value: jsonEncode(user.toJson()));
  }

 /* //get User

  Future<UserModel?> getUserDetails() async {
    final data = await storage.read(key: _UserData);
    if (data == null) return null;
    var res = UserModel.fromJson(jsonDecode(data));
    print("User id ....${res.id}");
    return UserModel.fromJson(jsonDecode(data));
  }*/
}
