part of 'get_friend_list_bloc.dart';

abstract class GetFriendListEvent extends Equatable {
  const GetFriendListEvent();

  @override
  List<Object> get props => [];
}

final class GetFriendListRequested extends GetFriendListEvent {
  final String token;

  const GetFriendListRequested({required this.token});
}

final class SearchFriendRequestRequired extends GetFriendListEvent {
  final String token;
  final String keyword;

  const SearchFriendRequestRequired(
      {required this.token, required this.keyword});
}

final class AddFriendRequestRequired extends GetFriendListEvent {
  final String token;
  final User friend;

  const AddFriendRequestRequired({required this.token, required this.friend});
}
