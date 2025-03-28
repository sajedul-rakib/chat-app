import 'package:bloc/bloc.dart';
import 'package:chat_app/shared/shared.dart';
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
      String result=await _loginRepo.checkUserLoggedIn();
      String userId=await SharedData.getLocalSaveItem("id")?? '';
      if (result.isNotEmpty && userId.isNotEmpty) {
        emit(AuthenticationState.authenticate(result,userId));
      } else {
        emit(const AuthenticationState.unAuthenticate());
      }
    });
  }
}
