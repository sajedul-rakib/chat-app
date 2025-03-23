part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpProcess extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final bool isSuccess;
  const SignUpSuccess({required this.isSuccess});
}

final class SignUpFailure extends SignUpState {
  final String errorMessage;
  const SignUpFailure({required this.errorMessage});
}
