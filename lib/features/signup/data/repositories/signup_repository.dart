import 'dart:io';

import 'package:chat_app/apis/model/response_model.dart';

import '../models/model.dart';

abstract class SignupRepo {
  //sign up
  Future<ResponseModel> signUp(
      {required MyUser user, required String password,required File? profilePic});
}
