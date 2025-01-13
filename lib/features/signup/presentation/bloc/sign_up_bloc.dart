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
        emit(SignUpProccess());
        MyUser user = await _signupRepo.signUpWithEmailAndPassword(
            user: event.user, password: event.password, picPath: event.picPath);
        emit(SignUpSuccess(myUser: user));
      } catch (e) {
        log('from bloc : ${e.toString()}');
        emit(SignUpFailure(errorMessage: e.toString()));
        rethrow;
      }
    });
  }
}
