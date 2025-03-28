part of 'get_friend_list_bloc.dart';

abstract class GetFriendListState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetFriendListInitial extends GetFriendListState {}
final class GetFriendListLoading extends GetFriendListState {}
final class GetFriendListSuccess extends GetFriendListState {
  final String userId;
  final List<Conversation> friendList;

  GetFriendListSuccess({required this.userId, required this.friendList});
}
final class GetFriendListFailure extends GetFriendListState {
  final String? errMsg;

  GetFriendListFailure({this.errMsg});
}

final class SearchFriendLoading extends GetFriendListState {}
final class SearchFriendSuccess extends GetFriendListState {

}
final class SearchFriendFailure extends GetFriendListState {
  final String? errMsg;
  SearchFriendFailure({this.errMsg});
}

final class AddFriendLoading extends GetFriendListState{}
final class AddFriendSuccess extends GetFriendListState{
  final Conversation conversation;
  AddFriendSuccess({required this.conversation});
}
final class AddFriendFailure extends GetFriendListState{
  final String? errMsg;
  AddFriendFailure({this.errMsg});
}
