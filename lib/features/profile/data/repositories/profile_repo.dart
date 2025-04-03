

import 'package:chat_app/apis/model/response_model.dart';

abstract class ProfileRepo{
  //get user details troughs logged user id
  Future<ResponseModel> getUserDetail({required String userId,required String token});
}