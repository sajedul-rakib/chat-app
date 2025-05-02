part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class CheckUserLoggedIn extends AuthenticationEvent {
  const CheckUserLoggedIn();
}

final class AppLoggedIn extends AuthenticationEvent {
  final String token;
  const AppLoggedIn(this.token);
}

final class AppLogOut extends AuthenticationEvent {
  const AppLogOut();
}
