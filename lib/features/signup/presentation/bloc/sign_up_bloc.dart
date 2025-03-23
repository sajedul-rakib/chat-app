import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/signup/domain/repositories/signup_repo.dart';
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
        bool isSuccess = await _signupRepo.signUp(
            user: event.user, password: event.password);
        emit(SignUpSuccess(isSuccess: isSuccess));
      } catch (e) {
        log('from sign up bloc : ${e.toString()}');
        emit(SignUpFailure(errorMessage: e.toString()));
        rethrow;
      }
    });
  }
}
