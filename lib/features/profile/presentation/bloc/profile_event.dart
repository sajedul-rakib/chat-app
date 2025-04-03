part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetUserDetailRequired extends ProfileEvent {
  GetUserDetailRequired();
}
