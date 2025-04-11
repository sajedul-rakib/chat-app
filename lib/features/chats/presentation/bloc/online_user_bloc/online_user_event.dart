part of 'online_user_bloc.dart';

@immutable
abstract class OnlineUserEvent {}


final class ConnectToSocket extends OnlineUserEvent{

}


final class UserOnlineStatusChanged extends OnlineUserEvent{
  final String userId;
  final bool isOnline;
  UserOnlineStatusChanged(this.userId,this.isOnline);
}