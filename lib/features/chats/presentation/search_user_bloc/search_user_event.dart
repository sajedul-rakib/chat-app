part of 'search_user_bloc.dart';

@immutable
abstract class SearchUserEvent {}

final class SearchFriendRequestRequired extends SearchUserEvent {
  final String token;
  final String keyword;

  SearchFriendRequestRequired({required this.token, required this.keyword});
}
