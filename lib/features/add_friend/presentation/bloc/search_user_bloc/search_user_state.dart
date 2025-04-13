part of 'search_user_bloc.dart';

@immutable
abstract class SearchUserState extends Equatable {
  const SearchUserState();
}

final class SearchUserInitial extends SearchUserState {
  const SearchUserInitial();

  @override
  List<Object?> get props => [];
}

final class SearchFriendLoading extends SearchUserState {
  const SearchFriendLoading();

  @override
  List<Object?> get props => [];
}

final class SearchFriendSuccess extends SearchUserState {
  final SearchModel searchResult;

  const SearchFriendSuccess({required this.searchResult});

  @override
  // TODO: implement props
  List<Object?> get props => [searchResult];
}

final class SearchFriendFailure extends SearchUserState {
  final String? errMsg;

  const SearchFriendFailure({this.errMsg});

  @override
  // TODO: implement props
  List<Object?> get props => [errMsg];
}
