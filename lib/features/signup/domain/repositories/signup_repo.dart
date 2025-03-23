import 'dart:developer';

import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/features/signup/data/models/user.dart';

import '../../data/repositories/signup_repository.dart';

class SignupRepo implements SignupRepository {
  @override
  Future<bool> signUp(
      {required MyUser user,
      required String password,
     }) async {
    try {
      final signUp = await ApiService.callApiWithPostMethod(
          url: ApiEndPoints.signUp,
          body: {...user.toEntity().toDocument(), 'password': password});
      log(signUp.body.toString());
      if (signUp.status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      log(err.toString());
      return false;
    }
  }
}
