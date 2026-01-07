import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
import 'package:e_commerce_app/Storage/SecureStorageHelper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // GET request

  Future<http.Response> getData(String endpoint) async {
    final url = ApiEndPoints.baseUrl + endpoint;
    print("GET -> $url");
    final response = await http.get(Uri.parse(url));
    return response;
  }

  Future<List<dynamic>> getDataApiList(String endpoint) async {
    final url = ApiEndPoints.baseUrl + endpoint;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error ${response.statusCode}");
    }
  }

  static Future<List<dynamic>> getCategoryProducts(String categoryId) async {
    final url = "${ApiEndPoints.baseUrl}categories/${categoryId}/products";
    // final url = "https://api.escuelajs.co/api/v1/categories/4/products";
    print("GET -> $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("API Response: $response");
      return data;
    } else {
      throw Exception("Failed to load products");
    }
  }

  // POST request
  Future<http.Response> postData(String endpoint, Map body) async {
    final url = ApiEndPoints.baseUrl + endpoint;
    print("POST -> $url");

    return await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
  }

  //Get UserProfile

  static Future<UserModel> getUserProfile(String accessToken) async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.getProfile;
    print("User -> $url");
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    print("response.statusCode ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  // update user

  Future<http.Response> updateUserProfile(
    int id,
    String name,
    String email,
    String? token,
  ) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.updateUserProfile}/$id";
    print("UpdateUser -> $url");

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"name": name, "email": email}),
    );

    return response;
  }

  // Refresh access token

  Future<String?> refreshToke() async {
    final getrefreshtoken = SecureStorageHelper.instance.get_RefreshToken();
    if (getrefreshtoken == null) return null;
    final url = ApiEndPoints.baseUrl + ApiEndPoints.getRefreshToken;
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": getrefreshtoken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newtoken = data["access_token"];
      await SecureStorageHelper.instance.save_Token(accesstoken: newtoken);
      print("new Access token  ${newtoken}");
    }

    return null;
  }

  Future<http.Response> updateProfileImage(
    int userId,
    String token,
    File imageFile,
  ) async {
    final url = Uri.parse(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.updateUserProfile}/$userId",
    );

    var request = http.MultipartRequest('PUT', url);

    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(
      await http.MultipartFile.fromPath('avatar', imageFile.path),
    );

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> updateUserProfile1(
    int userId,
    String token,
    String name,
    String email,
    String? avatarUrl,
  ) async {
    final url = Uri.parse(
      "${ApiEndPoints.baseUrl}${ApiEndPoints.updateUserProfile}/$userId",
    );

    final body = {"name": name, "email": email};

    if (avatarUrl != null) {
      body["avatar"] = avatarUrl;
    }

    return await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }
}
