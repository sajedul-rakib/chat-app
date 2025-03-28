import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repositories/login_repo.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final LoginRepo _loginRepo;

  SignInBloc({required LoginRepo loginRepo})
      : _loginRepo = loginRepo,
        super(SignInInitial()) {
    //log in handler
    on<SignInRequired>((event, emit) async {
      emit(SignInProccess());
      try {
        final response = await _loginRepo.signIn(
            email: event.email, password: event.password);
        if (response) {
          emit(SignInSuccess());
        } else {
          emit(SignInFailure(errorMessage: "Log in Failed"));
        }
      } catch (e) {
        emit(SignInFailure(errorMessage: e.toString()));
        log('from signIn bloc:${e.toString()}');
        rethrow;
      }
    });
    //log out handler
    on<SignOutRequired>((event, emit) async {
      emit(SignOutProccess());
      try {
        bool result = await _loginRepo.logOut();
        if (result) {
          emit(SignOutSuccess());
        } else {
          emit(SignOutFailure());
        }
      } catch (e) {
        emit(SignOutFailure(errorMessage: e.toString()));
        rethrow;
      }
    });
  }
}
