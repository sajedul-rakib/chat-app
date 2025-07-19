import 'dart:async';
import 'dart:convert';

import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/shared/shared.dart';

import '../../data/repositories/login_repository.dart';

class LoginRepoImpl extends LogInRepo {
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
    return getToken ?? '';
  }

  @override
  Future<bool> logOut() async {
    return SharedData.deleteAllSave();
  }
}
