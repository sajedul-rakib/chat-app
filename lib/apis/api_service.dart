import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<ResponseModel> callApiWithGetMethod({
    required String url,
    String token = '',
  }) async {
    try {
      final Uri parseUrl = Uri.parse(url);
      final response = await http.get(
        parseUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // Handle non-200 status codes
      if (response.statusCode >= 400) {
        return ResponseModel(
          status: response.statusCode,
          errMsg: {...jsonDecode(response.body)},
        );
      }

      // Parse JSON safely
      try {
        final responseBody = jsonDecode(response.body);
        return ResponseModel(status: response.statusCode, body: responseBody);
      } catch (jsonError) {
        return ResponseModel(
          status: response.statusCode,
          errMsg: {
            "errors": {
              "common": {"msg": "Invalid JSON Response"}
            }
          },
        );
      }
    } on SocketException catch (e) {
      if (e.message.contains("Connection refused")) {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": "Server is unreachable"}
            }
          },
        );
      }
      if (e.message.contains('Connection failed')) {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": "No Internet Connection"}
            }
          },
        );
      } else {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": e.message}
            }
          },
        );
      }
    } on HttpException {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": "Failed To Load Data"}
          }
        },
      );
    } on FormatException {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": "Bad Response Format"}
          }
        },
      );
    } catch (e) {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": e.toString()}
          }
        },
      );
    }
  }

  //post api
  static Future<ResponseModel> callApiWithPostMethod({
    required String url,
    required Map<String, dynamic> body,
    String token = '',
  }) async {
    try {
      final Uri parseUrl = Uri.parse(url);
      final response = await http.post(
        parseUrl,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // Handle HTTP errors
      if (response.statusCode >= 400) {
        return ResponseModel(
          status: response.statusCode,
          errMsg: {...jsonDecode(response.body)},
        );
      }

      // Safe JSON decoding
      try {
        final responseBody = jsonDecode(response.body);
        return ResponseModel(status: response.statusCode, body: responseBody);
      } catch (jsonError) {
        return ResponseModel(
          status: response.statusCode,
          errMsg: {
            "errors": {
              "common": {"msg": "Invalid Json response"}
            }
          },
        );
      }
    } on SocketException catch (e) {
      if (e.message.contains("Connection refused")) {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": "Server is unreachable"}
            }
          },
        );
      }
      if (e.message.contains('Connection failed')) {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": "No Internet Connection"}
            }
          },
        );
      } else {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": e.message}
            }
          },
        );
      }
    } on HttpException {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": "Failed to send request"}
          }
        },
      );
    } on FormatException {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": "Bad Response Format"}
          }
        },
      );
    } catch (e) {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": e.toString()}
          }
        },
      );
    }
  }

  //multipart post method
  static Future<ResponseModel> callApiWithMultiPartPostRequest({
    required String url,
    required Map<String, dynamic> body,
    required File? imagePath,
    String token = '',
  }) async {
    try {
      final Uri parseUrl = Uri.parse(url);
      final request = http.MultipartRequest("POST", parseUrl);

      // Add headers
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });

      // Add form fields dynamically
      body.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      // Attach image if available
      if (imagePath != null) {
        final mimeType = lookupMimeType(imagePath.path) ?? 'image/jpeg';
        request.files.add(await http.MultipartFile.fromPath(
          'profilePic',
          imagePath.path,
          contentType: MediaType.parse(mimeType),
        ));
      }

      final response = await request.send();

      // Read response body as a string
      final responseBody = await response.stream.bytesToString();

      // Handle HTTP errors
      if (response.statusCode >= 400) {
        return ResponseModel(
          status: response.statusCode,
          errMsg: {...jsonDecode(responseBody)},
        );
      }

      // Parse JSON safely
      try {
        final parsedBody = jsonDecode(responseBody);
        return ResponseModel(status: response.statusCode, body: parsedBody);
      } catch (jsonError) {
        return ResponseModel(
          status: response.statusCode,
          errMsg: {
            "errors": {
              "common": {"msg": "Invalid JSON Response"}
            }
          },
        );
      }
    } on SocketException catch (e) {
      if (e.message.contains("Connection refused")) {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": "Server is unreachable"}
            }
          },
        );
      }
      if (e.message.contains('Connection failed')) {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": "No Internet Connection"}
            }
          },
        );
      } else {
        return ResponseModel(
          status: 500,
          errMsg: {
            "errors": {
              "common": {"msg": e.message}
            }
          },
        );
      }
    } on HttpException {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": "Failed to Sent Request"}
          }
        },
      );
    } on FormatException {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": "Bad Response Format"}
          }
        },
      );
    } catch (e) {
      return ResponseModel(
        status: 500,
        errMsg: {
          "errors": {
            "common": {"msg": e.toString()}
          }
        },
      );
    }
  }
}
