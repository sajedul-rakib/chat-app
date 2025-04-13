part of 'add_user_bloc.dart';

@immutable
sealed class AddUserState {}

final class AddUserInitial extends AddUserState {}

final class AddFriendLoading extends AddUserState{}
final class AddFriendSuccess extends AddUserState{
  AddFriendSuccess();
}
final class AddFriendFailure extends AddUserState{
  final String? errMsg;
  AddFriendFailure({this.errMsg});
}
