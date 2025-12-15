import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static late SharedPreferences sharedPreferences;

  static String _isLoggedIn = "is_logged_in";
  static String _token = "token";
  static String _email = "email";

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


class shared{
  Future<SharedPreferences> get sharedpref async => await SharedPreferences.getInstance();
}

