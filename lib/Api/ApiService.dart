import 'dart:convert';

import 'package:e_commerce_app/Api/ApiEndPoints.dart';
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
    final url = "${ApiEndPoints.baseUrl}/categories/$categoryId/products";
    print("GET -> $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }

  // POST request
  Future<http.Response> postData(String endpoint, Map body) async {
    /*final url = ApiEndPoints.baseUrl + endpoint;
    print("POST -> $url");
    return await http.post(url as Uri, body: body);*/

    final url = ApiEndPoints.baseUrl + endpoint;
    print("POST -> $url");

    return await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
  }


}
