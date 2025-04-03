import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/route_name.dart';
import '../../../contacts/presentation/widgets/friend_list_tile.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../../../widgets/custom_snackbar.dart';
import '../bloc/bloc/get_friend_list_bloc.dart';
import 'no_friend_ui.dart';

class FriendListUi extends StatelessWidget {
  const FriendListUi({
    super.key,
    required TextEditingController friendGmailETController,
  }) : _friendGmailETController = friendGmailETController;

  final TextEditingController _friendGmailETController;

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
            ? ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.friendList.conversation!.length,
                itemBuilder: (_, index) {
                  if (state.userId ==
                      state.friendList.conversation![index].owner!.sId) {
                    return FriendListTile(
                      user: state.friendList.conversation![index].participant!,
                      lastMessage:
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
                      lastMessage:
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
                separatorBuilder: (_, int index) {
                  return const Divider();
                },
              )
            : NoFriendUi(friendGmailETController: _friendGmailETController);
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
