part of 'get_friend_list_bloc.dart';

abstract class GetFriendListState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetFriendListInitial extends GetFriendListState {}
final class GetFriendListLoading extends GetFriendListState {}
final class GetFriendListSuccess extends GetFriendListState {
  final String userId;
  final ConversationModel friendList;

  GetFriendListSuccess({required this.userId, required this.friendList});
}
final class GetFriendListFailure extends GetFriendListState {
  final String? errMsg;

  GetFriendListFailure({this.errMsg});
}
