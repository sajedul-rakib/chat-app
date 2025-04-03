import 'package:chat_app/apis/api_endpoints.dart';
import 'package:chat_app/apis/api_service.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repo.dart';

class ProfileRepository extends ProfileRepo {
  @override
  Future<ResponseModel> getUserDetail(
      {required String userId, required String token}) async {
    try {
      final response = await ApiService.callApiWithPostMethod(
          url: ApiEndPoints.userDetail, token: token, body: {'id': userId});

      return response;
    } catch (err) {
      return ResponseModel(status: 500, errMsg: {"errMsg": err});
    }
  }
}
