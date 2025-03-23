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
    on<AuthenticationUserChanged>((event, emit)async {
      bool result=await _loginRepo.checkUserLoggedIn();
      if (result) {
        emit(AuthenticationState.authenticate());
      } else {
        emit(const AuthenticationState.unAuthenticate());
      }
    });
  }
}
