part of 'authentication_bloc.dart';

enum AuthenticateStatus { authenticate, unauthenticate, unknown }

final class AuthenticationState extends Equatable {
  final AuthenticateStatus status;
  final User? user;

  const AuthenticationState._(
      {this.status = AuthenticateStatus.unknown, this.user});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unauthenticate()
      : this._(status: AuthenticateStatus.unauthenticate);

  const AuthenticationState.authenticate(User user)
      : this._(status: AuthenticateStatus.authenticate, user: user);

  @override
  List<Object?> get props => [status, user];
}
