part of 'authentication_bloc.dart';

enum AuthenticateStatus { authenticate, unAuthenticate, unknown }

final class AuthenticationState extends Equatable {
  final String userToken;
  final String userId;
  final AuthenticateStatus status;

  const AuthenticationState._(
      {this.status = AuthenticateStatus.unknown,
      this.userToken = '',
      this.userId = ''});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unAuthenticate()
      : this._(status: AuthenticateStatus.unAuthenticate);

  const AuthenticationState.authenticate(String userToken, String userId)
      : this._(
            status: AuthenticateStatus.authenticate,
            userToken: userToken,
            userId: userId);

  @override
  List<Object?> get props => [status];
}
