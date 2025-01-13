part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpProccess extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final MyUser? myUser;
  const SignUpSuccess({this.myUser});
}

final class SignUpFailure extends SignUpState {
  final String errorMessage;
  const SignUpFailure({required this.errorMessage});
}
