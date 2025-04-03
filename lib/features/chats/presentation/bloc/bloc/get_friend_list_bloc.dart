import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/apis/model/response_model.dart';
import 'package:chat_app/common/model/errorModel.dart';
import 'package:chat_app/features/chats/data/models/conversation_model.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:equatable/equatable.dart';

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
        ResponseModel result = await _chatRepo.getFriendList(event.token);
        String userId = await SharedData.getLocalSaveItem("userId") ?? '';
        if (result.status == 200 && userId.isNotEmpty) {
          emit(GetFriendListSuccess(
              userId: userId,
              friendList: ConversationModel.fromJson(result.body!)));
        } else {
          if (userId.isEmpty) {
            emit(GetFriendListFailure(errMsg: "Log in session expired"));
          } else {
            log(result.errMsg.toString());
            String errMsg =
                ErrorModel.fromJson(result.errMsg!).errors?.errMsg?.msg ?? '';
            emit(GetFriendListFailure(errMsg: errMsg));
          }
        }
      } catch (e) {
        emit(GetFriendListFailure(errMsg: e.toString()));
        rethrow;
      }
    });
  }
}
