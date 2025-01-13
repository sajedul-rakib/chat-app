import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../login/domain/repositories/login_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepo _loginRepo;
  late final StreamSubscription<User?> _streamSubscription;

  AuthenticationBloc({required LoginRepo loginRepo})
      : _loginRepo = loginRepo,
        super(const AuthenticationState.unknown()) {
    _streamSubscription = _loginRepo.user.listen((authUser) {
      add(AuthenticationUserChanged(user: authUser));
    });
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationState.authenticate(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticate());
      }
    });
  }
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
