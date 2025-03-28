import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chats/data/models/Conversation.dart';
import 'package:chat_app/features/chats/data/models/conversation_model.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/user.dart';

part 'get_friend_list_event.dart';

part 'get_friend_list_state.dart';

class GetFriendListBloc extends Bloc<GetFriendListEvent, GetFriendListState> {
  final ChatRepo _chatRepo;

  GetFriendListBloc({required ChatRepo chatRepo})
      : _chatRepo = chatRepo,
        super(GetFriendListInitial()) {
    on<GetFriendListRequested>((event, emit) async {
      try {
        emit(GetFriendListLoading());
        ConversationModel conversationModel =
            await _chatRepo.getFriendList(event.token);
        String userId = await SharedData.getLocalSaveItem("id") ?? '';
        if (conversationModel.conversation != null) {
          emit(GetFriendListSuccess(
              userId: userId, friendList: conversationModel.conversation!));
        } else {
          emit(GetFriendListFailure());
        }
      } catch (e) {
        emit(GetFriendListFailure(errMsg: e.toString()));
        rethrow;
      }
    });

    on<SearchFriendRequestRequired>((event, emit) async {
      emit(SearchFriendLoading());
      try {
        final result = await _chatRepo.searchUser(event.token, event.keyword);
      } catch (err) {
        emit(SearchFriendFailure(errMsg: err.toString()));
      }
    });

    on<AddFriendRequestRequired>((event, emit) async {
      emit(AddFriendLoading());
      try {
        final result =
            await _chatRepo.addFriend(event.token, event.friend.toJson());
        if (result != null) {
          emit(AddFriendSuccess(conversation: result));
        } else {
          emit(AddFriendFailure());
        }
      } catch (err) {
        emit(SearchFriendFailure(errMsg: err.toString()));
      }
    });
  }
}
