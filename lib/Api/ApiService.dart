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

/* // POST request
  Future<http.Response> postData(String endpoint, Map body) async {
    final url = ApiEndPoints.baseUrl + endpoint;
    print("POST -> $url");
    return await http.post(url as Uri, body: body);
  }*/
}
