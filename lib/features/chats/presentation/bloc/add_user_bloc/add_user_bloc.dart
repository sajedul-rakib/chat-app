import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:meta/meta.dart';

import '../../../data/models/Conversation.dart';
import '../../../data/models/user.dart';
import '../get_user_bloc/get_friend_list_bloc.dart';

part 'add_user_event.dart';

part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final ChatRepo _chatRepo;

  AddUserBloc({required ChatRepo chatRepo})
      : _chatRepo = chatRepo,
        super(AddUserInitial()) {
    on<AddFriendRequestRequired>((event, emit) async {
      emit(AddFriendLoading());
      try {
        String token=await SharedData.getLocalSaveItem("token") ?? '';
        final result =
            await _chatRepo.addFriend(token, event.friend.toJson());

        if (result.status == 200) {
          if (state is GetFriendListSuccess) {
            final prevFriendState = state as GetFriendListSuccess;
            final prevFriend = prevFriendState.friendList;
            Conversation newConversation = Conversation.fromJson(result.body!);
            prevFriend.conversation!.add(newConversation);
            emit(AddFriendSuccess(conversation: newConversation));
          }
        }
      } catch (err) {
        emit(AddFriendFailure(errMsg: err.toString()));
      }
    });
  }
}
