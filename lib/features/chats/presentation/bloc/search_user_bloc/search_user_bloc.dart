
import 'package:bloc/bloc.dart';
import 'package:chat_app/common/model/errorModel.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/models/search_model.dart';

part 'search_user_event.dart';

part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final ChatRepo _chatRepo;

  SearchUserBloc({required ChatRepo chatRepo})
      : _chatRepo = chatRepo,
        super(SearchUserInitial()) {
    on<SearchFriendRequestRequired>((event, emit) async {
      emit(SearchFriendLoading());
      try {
        String token = await SharedData.getLocalSaveItem("token") ?? '';
        final result = await _chatRepo.searchUser(token, event.keyword);
        if (result.status == 200) {
          emit(SearchFriendSuccess(
              searchResult: SearchModel.fromJson(result.body!)));
        } else {
          String errMsg =
              ErrorModel.fromJson(result.errMsg!).errors?.errMsg?.msg ?? '';
          emit(SearchFriendFailure(errMsg: errMsg));

        }
      } catch (err) {
        emit(SearchFriendFailure(errMsg: err.toString()));
      }
    });

    on<SearchUserReset>((event,emit){
      emit(SearchUserInitial());
    });
  }
}
