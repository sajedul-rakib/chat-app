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
        log(response.body.toString());
        SharedData.saveToLocal("token", response.body['token']);
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
  Future<bool> checkUserLoggedIn() async {
    try {
      String getToken = await SharedData.getLocalSaveItem('token') ?? '';

      if (getToken.isNotEmpty) {
        log(getToken);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
