import 'dart:developer';

import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/shared/shared.dart';

import '../../data/repositories/login_repository.dart';

class LoginRepo extends LogInRepository {
  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      final response = await ApiService.callApiWithPostMethod(
          url: ApiEndPoints.signIn,
          body: {"email": email, 'password': password});

      if (response.status == 200) {
        //save user token
        SharedData.saveToLocal("token", response.body['token']);
        SharedData.saveToLocal("id", response.body['id']);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  @override
  Future<String> checkUserLoggedIn() async {
    try {
      String getToken = await SharedData.getLocalSaveItem('token') ?? '';

      if (getToken.isNotEmpty) {
        return getToken;
      } else {
        return '';
      }
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  @override
  Future<bool> logOut() async {
   return SharedData.deleteAllSave();
  }
}
