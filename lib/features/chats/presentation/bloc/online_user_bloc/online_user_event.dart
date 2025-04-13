part of 'online_user_bloc.dart';

@immutable
abstract class OnlineUserEvent extends Equatable {}

final class ConnectToSocket extends OnlineUserEvent {
  @override
  List<Object?> get props => [];
}

final class UserOnlineStatusChanged extends OnlineUserEvent {
  final List<String> onlineUser;

  UserOnlineStatusChanged(this.onlineUser);

  @override
  List<Object?> get props => [onlineUser];
}

final class UserGoOffline extends OnlineUserEvent {
  UserGoOffline();

  @override
  List<Object?> get props => [];
}
