part of 'authentication_bloc.dart';

enum AuthenticateStatus { authenticate, unAuthenticate, unknown }

final class AuthenticationState extends Equatable {
  final AuthenticateStatus status;
  const AuthenticationState._(
      {this.status = AuthenticateStatus.unknown});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unAuthenticate()
      : this._(status: AuthenticateStatus.unAuthenticate);

  const AuthenticationState.authenticate()
      : this._(status: AuthenticateStatus.authenticate);

  @override
  List<Object?> get props => [status];
}
