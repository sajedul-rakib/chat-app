import 'dart:io';

import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/features/signup/data/models/user.dart';

import '../../data/repositories/signup_repository.dart';

class SignupRepoImpl implements SignupRepo {
  @override
  Future<ResponseModel> signUp(
      {required MyUser user,
      required String password,
      required File? profilePic}) async {
    try {
      final signUp = await ApiService.callApiWithMultiPartPostRequest(
          url: ApiEndPoints.signUp,
          body: {...user.toEntity().toDocument(), 'password': password},
          imagePath: profilePic);
      if (signUp.status == 200) {
        return signUp;
      } else {
        return signUp;
      }
    } catch (err) {
      return ResponseModel(status: 500, errMsg: {
        'errMsg': {
          'common': {'msg': "Sign up failed"}
        }
      });
    }
  }
}
