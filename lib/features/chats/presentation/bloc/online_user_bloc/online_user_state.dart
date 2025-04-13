part of 'online_user_bloc.dart';

@immutable
abstract class OnlineUserState extends Equatable {}

final class OnlineUserInitial extends OnlineUserState {
  @override
  List<Object?> get props => [];
}


final class OnlineUsersUpdated extends OnlineUserState{
  final List<String> onlineUser;

  OnlineUsersUpdated(this.onlineUser);

  @override
  // TODO: implement props
  List<Object?> get props => [onlineUser];
}
