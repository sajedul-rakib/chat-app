part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}


final class GetUserDataProcess extends ProfileState {}
final class GetUserDataSuccess extends ProfileState {
  final User user;
  GetUserDataSuccess({required this.user});
}
final class GetUserDataFailure extends ProfileState {
  final String? errMsg;
  GetUserDataFailure({this.errMsg});
}
