part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInProccess extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInFailure extends SignInState {
  final String errorMessage;
  const SignInFailure({required this.errorMessage});
}

final class SignOutProccess extends SignInState {}

final class SignOutSuccess extends SignInState {}

final class SignOutFailure extends SignInState {
  final String errorMessage;
  const SignOutFailure({required this.errorMessage});
}
