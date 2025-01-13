import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chats/domain/repositories/user_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../../signup/data/models/user.dart';

part 'get_friend_list_event.dart';
part 'get_friend_list_state.dart';

class GetFriendListBloc extends Bloc<GetFriendListEvent, GetFriendListState> {
  final UserRepo _userRepo;
  GetFriendListBloc({required UserRepo userRepo})
      : _userRepo = userRepo,
        super(GetFriendListState.initial()) {
    on<GetFriendListRequested>((event, emit) async {
      try {
        emit(GetFriendListState.loading());
        List<MyUser> friendList =
            await _userRepo.getSubscriberFriendList(event.subscriberId);
        emit(GetFriendListState.success(friendList));
      } catch (e) {
        emit(GetFriendListState.failure(e.toString()));
        rethrow;
      }
    });
  }
}
