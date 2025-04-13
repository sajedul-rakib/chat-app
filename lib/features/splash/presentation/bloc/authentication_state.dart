part of 'authentication_bloc.dart';

enum AuthenticateStatus { authenticate, unAuthenticate, unknown }

final class AuthenticationState extends Equatable {
  final String userToken;
  final AuthenticateStatus status;

  const AuthenticationState._({
    this.status = AuthenticateStatus.unknown,
    this.userToken = '',
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unAuthenticate()
      : this._(status: AuthenticateStatus.unAuthenticate);

  const AuthenticationState.authenticate(String userToken)
      : this._(
          status: AuthenticateStatus.authenticate,
          userToken: userToken,
        );

  @override
  List<Object?> get props => [status];
}
