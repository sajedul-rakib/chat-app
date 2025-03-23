import 'dart:convert';
import 'dart:developer';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //get method
  static Future<ResponseModel> callApiWithGetMethod(
      {required String url, String token = ''}) async {
    //Uri parse
    try {
      final Uri parseUrl = Uri.parse(url);
      http.Response response = await http.get(parseUrl);

      return ResponseModel(
          status: response.statusCode,
          body: response.body as Map<String, dynamic>);
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  //post method
  static Future<ResponseModel> callApiWithPostMethod(
      {required String url,
      required Map<String, dynamic> body,
      String token = ''}) async {
    //Uri parse
    try {
      final Uri parseUrl = Uri.parse(url);
      http.Response response = await http.post(parseUrl,
          body: jsonEncode(body),
          headers: {"content-type": 'application/json', "token": token});

      return ResponseModel(
          status: response.statusCode,
          body: jsonDecode(response.body));
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }
}
