part of 'get_friend_list_bloc.dart';

abstract class GetFriendListEvent extends Equatable {
  const GetFriendListEvent();

  @override
  List<Object> get props => [];
}

final class GetFriendListRequested extends GetFriendListEvent {
  const GetFriendListRequested();
}
