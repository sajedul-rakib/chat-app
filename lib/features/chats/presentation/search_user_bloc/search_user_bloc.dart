import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:meta/meta.dart';

import '../../data/models/search_model.dart';

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
        final result = await _chatRepo.searchUser(event.token, event.keyword);
        emit(SearchFriendSuccess(
            searchResult: SearchModel.fromJson(result.body!)));
      } catch (err) {
        emit(SearchFriendFailure(errMsg: err.toString()));
      }
    });
  }
}
