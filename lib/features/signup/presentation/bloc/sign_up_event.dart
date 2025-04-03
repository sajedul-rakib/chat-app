part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;
  final File? profilePic;

  const SignUpRequired(
      {required this.user, required this.password,required this.profilePic});
}
