import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../login/domain/repositories/login_repo.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepo _loginRepo;
  late final StreamSubscription _userSubscription;

  AuthenticationBloc({required LoginRepo loginRepo})
      : _loginRepo = loginRepo,
        super(const AuthenticationState.unknown()) {
    on<AppLoggedIn>((event, emit) {
      emit(AuthenticationState.authenticate(event.token));
    });

    on<AppLogOut>((event, emit) {
      emit(AuthenticationState.unAuthenticate());
    });

    _userSubscription = _loginRepo.userStream.listen((token) {
      if (token != null && token.isNotEmpty) {
        add(AppLoggedIn(token));
      } else {
        add(AppLogOut());
      }
    });

    loginRepo.checkUserLoggedIn();
    // on<AuthenticationUserChanged>((event, emit)async {
    //   String result=await _loginRepo.checkUserLoggedIn();
    //   String userId=await SharedData.getLocalSaveItem("userId")?? '';
    //   if (result.isNotEmpty && userId.isNotEmpty) {
    //
    //   } else {
    //
    //   }
    // });
  }

  @override
  Future<void> close() {
    log("close subscripiton");
    _userSubscription.cancel();
    return super.close();
  }
}
