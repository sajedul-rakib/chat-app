import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../bloc/search_user_bloc/search_user_bloc.dart';
import 'add_user_button.dart';

class UserSearchResult extends StatelessWidget {
  const UserSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocConsumer<SearchUserBloc, SearchUserState>(
        listener: (context, state) {
      if (state is SearchFriendFailure) {
        CustomSnackbar.show(context: context, message: state.errMsg ?? '');
      }
    }, builder: (context, state) {
      if (state is SearchFriendLoading) {
        return Center(
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: state
                                                      .searchResult
                                                      .user![index]
                                                      .profilePic !=
                                                  null &&
                                              state.searchResult.user![index]
                                                  .profilePic!.isNotEmpty
                                          ? NetworkImage(
                                              '${dotenv.env['BASE_URL']}${state.searchResult.user![index].profilePic!}')
                                          : state.searchResult.user![index]
                                                      .gender ==
                                                  'female'
                                              ? const AssetImage(
                                                      'assets/images/female.jpg')
                                                  as ImageProvider
                                              : const AssetImage(
                                                      'assets/images/man.jpg')
                                                  as ImageProvider,
                                    ),
                                    Text(
                                      state.searchResult.user![index]
                                              .fullName ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                    ),
                                  ],
                                ),
                                AddUserButton(
                                    user: state.searchResult.user![index])
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
      return SizedBox.shrink();
    });
  }
}
