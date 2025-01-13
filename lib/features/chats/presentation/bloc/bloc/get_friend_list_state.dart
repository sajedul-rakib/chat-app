part of 'get_friend_list_bloc.dart';

enum Status { initial, loading, success, failure }

final class GetFriendListState extends Equatable {
  final Status status;
  final List<MyUser>? friendList;
  final String? errorMessage;

  const GetFriendListState._(
      {this.status = Status.initial, this.friendList, this.errorMessage});

  const GetFriendListState.initial() : this._();

  const GetFriendListState.loading() : this._(status: Status.loading);

  const GetFriendListState.success(List<MyUser> myUser)
      : this._(status: Status.success, friendList: myUser);

  const GetFriendListState.failure(String errorMessage)
      : this._(errorMessage: errorMessage);
  @override
  List<Object> get props => [status];
}
