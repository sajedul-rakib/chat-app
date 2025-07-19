import 'package:chat_app/features/splash/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/route_name.dart';
import '../../../contacts/presentation/widgets/friend_list_tile.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../../../widgets/custom_snackbar.dart';
import '../bloc/get_user_bloc/get_friend_list_bloc.dart';
import 'no_friend_ui.dart';

class FriendListUi extends StatelessWidget {
  const FriendListUi({super.key, this.lastMessage});

  final String? lastMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetFriendListBloc, GetFriendListState>(
        builder: (context, state) {
      if (state is GetFriendListLoading) {
        return Center(
          child: CustomCircularProgressIndicator(),
        );
      } else if (state is GetFriendListSuccess) {
        return state.friendList.conversation!.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.friendList.conversation!.length,
                itemBuilder: (_, index) {
                  if (state.userId ==
                      state.friendList.conversation![index].owner!.sId) {
                    return FriendListTile(
                      user: state.friendList.conversation![index].participant!,
                      lastMessage: lastMessage ??
                          state.friendList.conversation![index].lastMessage,
                      onPressed: () => Navigator.pushNamed(
                          context, RouteName.conversationScreen,
                          arguments: {
                            'user': state
                                .friendList.conversation![index].participant,
                            'conversationId':
                                state.friendList.conversation![index].sId,
                            'loggedUserId':
                                state.friendList.conversation![index].owner?.sId
                          }),
                    );
                  } else {
                    return FriendListTile(
                      user: state.friendList.conversation![index].owner!,
                      lastMessage: lastMessage ??
                          state.friendList.conversation![index].lastMessage,
                      onPressed: () => Navigator.pushNamed(
                          context, RouteName.conversationScreen,
                          arguments: {
                            'user': state.friendList.conversation![index].owner,
                            'conversationId':
                                state.friendList.conversation![index].sId,
                            'loggedUserId': state.friendList
                                .conversation![index].participant?.sId
                          }),
                    );
                  }
                },
              )
            : NoFriendUi();
      } else if (state is GetFriendListFailure) {
        return SizedBox(
          width: 200,
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              AppButton(
                buttonTitle: "Retry",
                onPressed: () {
                  context
                      .read<GetFriendListBloc>()
                      .add(GetFriendListRequested());
                },
              ),
            ],
          )),
        );
      } else {
        return SizedBox.shrink();
      }
    }, listener: (context, state) {
      if (state is GetFriendListFailure) {
        CustomSnackbar.show(
            context: context,
            message: state.errMsg ?? "",
            backgroundColor: Theme.of(context).colorScheme.error);
      }
    });
  }
}
