part of 'add_user_bloc.dart';

@immutable
sealed class AddUserEvent {}




final class AddFriendRequestRequired extends AddUserEvent {
  final User friend;

   AddFriendRequestRequired({required this.friend});
}
