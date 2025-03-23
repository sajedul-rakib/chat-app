part of 'authentication_bloc.dart';

enum AuthenticateStatus { authenticate, unAuthenticate, unknown }

final class AuthenticationState extends Equatable {
  final AuthenticateStatus status;
  final String? token;
  const AuthenticationState._(
      {this.status = AuthenticateStatus.unknown, this.token});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unAuthenticate()
      : this._(status: AuthenticateStatus.unAuthenticate);

  const AuthenticationState.authenticate(String token)
      : this._(status: AuthenticateStatus.authenticate, token: token);

  @override
  List<Object?> get props => [status, token];
}
