part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoggedIn extends AuthenticationEvent {
  final String token;
  const AppLoggedIn(this.token);
}

class AppLogOut extends AuthenticationEvent{
  const AppLogOut();
}