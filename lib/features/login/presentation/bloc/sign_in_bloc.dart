import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/model/errorModel.dart';
import 'package:chat_app/features/login/data/repositories/login_repository.dart';
import 'package:chat_app/services/notification/local_notification.dart';
import 'package:equatable/equatable.dart';


part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final LogInRepo _loginRepo;

  SignInBloc({required LogInRepo loginRepo})
      : _loginRepo = loginRepo,
        super(SignInInitial()) {
    //log in handler
    on<SignInRequired>((event, emit) async {
      emit(SignInProccess());
      try {
        final String fcmToken =
            Platform.isIOS ? "" : FlutterNotification.fcmToken ?? '';
        final response = await _loginRepo.signIn(
            email: event.email, password: event.password, fcmToken: fcmToken);
        if (response.status == 200) {
        String token= response.body?['token'];
          emit(SignInSuccess(token));
        } else {
          String errMsg =
              ErrorModel.fromJson(response.errMsg!).errors?.errMsg?.msg ?? '';
          emit(SignInFailure(errorMessage: errMsg));
        }
      } catch (e) {
        emit(SignInFailure(errorMessage: e.toString()));
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
