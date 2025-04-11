part of 'search_user_bloc.dart';

@immutable
abstract class SearchUserEvent {
  const SearchUserEvent();
}

final class SearchFriendRequestRequired extends SearchUserEvent {
  final String keyword;

  const SearchFriendRequestRequired({required this.keyword});
}


final class SearchUserReset extends SearchUserEvent{
  const SearchUserReset();
}

