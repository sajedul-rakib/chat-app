import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repo.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileBloc({required ProfileRepo profileRepo})
      : _profileRepo = profileRepo,
        super(ProfileInitial()) {
    on<GetUserDetailRequired>((event, emit) async {
      emit(GetUserDataProcess());
      try {
        final String userId=await SharedData.getLocalSaveItem("userId") ?? '';
        final String token=await SharedData.getLocalSaveItem("token") ?? '';
        final result = await _profileRepo.getUserDetail(userId: userId,token: token);
          log(jsonEncode(result.body!));
        emit(GetUserDataSuccess(user: User.fromJson(result.body!['data'])));
      } catch (err) {
        log(err.toString());
        emit(GetUserDataFailure(errMsg: err.toString()));
      }
    });
  }
}
