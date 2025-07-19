import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/common/model/errorModel.dart';
import 'package:chat_app/features/signup/data/repositories/signup_repository.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/model.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignupRepo _signupRepo;

  SignUpBloc({required SignupRepo signUpRepo})
      : _signupRepo = signUpRepo,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      try {
        emit(SignUpProcess());
        ResponseModel response = await _signupRepo.signUp(
            user: event.user,
            password: event.password,
            profilePic: event.profilePic);

        if (response.status == 200) {
          emit(SignUpSuccess());
        } else {
          String errMsg =
              ErrorModel.fromJson(response.errMsg!).errors?.errMsg?.msg ?? '';
          emit(SignUpFailure(errorMessage: errMsg));
        }
      } catch (e) {
        emit(SignUpFailure(errorMessage: e.toString()));
      }
    });
  }
}
