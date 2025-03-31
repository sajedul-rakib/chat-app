import 'package:chat_app/features/chats/presentation/add_user_bloc/add_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../splash/presentation/widgets/app_button.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../search_user_bloc/search_user_bloc.dart';

class UserSearchResult extends StatelessWidget {
  const UserSearchResult(
      {super.key, required this.token, required this.textEditingController});

  final String token;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.secondaryDarkBackground.withValues(alpha: 2)),
        child: BlocBuilder<SearchUserBloc, SearchUserState>(
            builder: (context, state) {
          if (state is SearchFriendLoading) {
            Center(
              child: CustomCircularProgressIndicator(),
            );
          }
          if (state is SearchFriendSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                state.searchResult.user!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: state.searchResult.user?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          spacing: 10,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: state
                                                              .searchResult
                                                              .user?[index]
                                                              .profilePic !=
                                                          null &&
                                                      state
                                                          .searchResult
                                                          .user![index]
                                                          .profilePic!
                                                          .isNotEmpty
                                                  ? NetworkImage(state
                                                      .searchResult
                                                      .user![index]
                                                      .profilePic!)
                                                  : AssetImage(state
                                                              .searchResult
                                                              .user?[index]
                                                              .gender ==
                                                          'male'
                                                      ? 'assets/images/man.jpg'
                                                      : 'assets/images/female.jpg'),
                                            ),
                                            Text(
                                              state.searchResult.user?[index]
                                                      .fullName ??
                                                  ' ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: BlocListener<AddUserBloc,
                                          AddUserState>(
                                        listener: (context, state) {
                                          if (state is AddFriendSuccess) {
                                            textEditingController.clear();
                                          }
                                        },
                                        child: AppButton(
                                          buttonTitle: "Add",
                                          onPressed: () {
                                            context.read<AddUserBloc>().add(
                                                AddFriendRequestRequired(
                                                    token: token,
                                                    friend: state.searchResult
                                                        .user![index]));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }))
                    : Text(
                        "No user found",
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            );
          }
          if (state is SearchFriendFailure) {
            return Text(state.errMsg.toString());
          }
          return SizedBox.shrink();
        }));
  }
}
