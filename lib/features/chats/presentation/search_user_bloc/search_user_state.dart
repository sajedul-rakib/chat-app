part of 'search_user_bloc.dart';

@immutable
abstract class SearchUserState {}

final class SearchUserInitial extends SearchUserState {}


final class SearchFriendLoading extends SearchUserState {}
final class SearchFriendSuccess extends SearchUserState {
  final SearchModel searchResult;
  SearchFriendSuccess({required this.searchResult});
}
final class SearchFriendFailure extends SearchUserState {
  final String? errMsg;
  SearchFriendFailure({this.errMsg});
}
