import 'dart:async';
import 'dart:convert';

import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/shared/shared.dart';

import '../../data/repositories/login_repository.dart';

class LoginRepo extends LogInRepository {
  final _controller = StreamController<String?>.broadcast();

  Stream<String?> get userStream => _controller.stream;

  @override
  Future<ResponseModel> signIn(
      {required String email,
      required String password,
      String fcmToken = ''}) async {
    try {
      final response = await ApiService.callApiWithPostMethod(
          url: ApiEndPoints.signIn,
          body: {"email": email, 'password': password, 'fcmToken': fcmToken});

      if (response.status == 200) {
        SharedData.saveToLocal("token", response.body?['token']);
        SharedData.saveToLocal("userId", response.body?['id']);
        _controller.add(response.body?['token']);

        return response;
      } else {
        return response;
      }
    } catch (err) {
      return ResponseModel(
          status: 500, errMsg: jsonDecode('{errors: {common: {msg: $err}}}'));
    }
  }

  @override
  Future<String> checkUserLoggedIn() async {
    String? getToken = await SharedData.getLocalSaveItem('token');
    _controller.add(getToken?.isNotEmpty == true ? getToken : null);
    return getToken ?? '';
  }

  @override
  Future<bool> logOut() async {
    _controller.add(null);
    return SharedData.deleteAllSave();
  }
}
