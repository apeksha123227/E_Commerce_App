import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:e_commerce_app/Model/TabBar/Account/UserModel.dart';
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

  static Future<UserModel> getUserProfile(
    String accessToken
  ) async {
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
    if (response.statusCode == 200||response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
