import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../login/domain/repositories/login_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepo _loginRepo;

  AuthenticationBloc({required LoginRepo loginRepo})
      : _loginRepo = loginRepo,
        super(const AuthenticationState.unknown()) {
    on<AppLoggedIn>((event, emit) {
      log(event.token);
      emit(AuthenticationState.authenticate(event.token));
    });

    on<AppLogOut>((event, emit) {
      emit(AuthenticationState.unAuthenticate());
    });

    on<CheckUserLoggedIn>((event, emit) async {
      log("Check user are logged in or not");
      String result = await _loginRepo.checkUserLoggedIn();
      if (result.isNotEmpty) {
        emit(AuthenticationState.authenticate(result));
      } else {
        emit(AuthenticationState.unAuthenticate());
      }
    });
  }
}
