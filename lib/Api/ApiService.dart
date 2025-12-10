import 'package:e_commerce_app/Api/ApiEndPoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // GET request
  Future<http.Response> getData(String endpoint) async {
    final url = Uri.parse(ApiEndPoints.baseUrl + endpoint);
    print("GET -> $url");
    return await http.get(url);
    //return url;
  }

 /* // POST request
  Future<http.Response> postData(String endpoint, Map body) async {
    final url = ApiEndPoints.baseUrl + endpoint;
    print("POST -> $url");
    return await http.post(url as Uri, body: body);
  }*/
}
