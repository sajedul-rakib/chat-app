import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../splash/presentation/widgets/app_button.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../bloc/add_user_bloc/add_user_bloc.dart';
import '../bloc/search_user_bloc/search_user_bloc.dart';

class UserSearchResult extends StatelessWidget {
  const UserSearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<SearchUserBloc, SearchUserState>(
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(spacing: 10,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: state.searchResult.user![index]
                                                    .profilePic !=
                                                null &&
                                            state.searchResult.user![index]
                                                .profilePic!.isNotEmpty
                                        ? NetworkImage(
                                            '${dotenv.env['BASE_URL']}${state.searchResult.user![index].profilePic!}')
                                        : state.searchResult.user![index].gender ==
                                                'female'
                                            ? const AssetImage(
                                                    'assets/images/female.jpg')
                                                as ImageProvider
                                            : const AssetImage(
                                                    'assets/images/man.jpg')
                                                as ImageProvider,
                                  ),
                                  Text(
                                    state.searchResult.user![index].fullName ?? '',
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
                              AppButton(
                                buttonTitle: "Add Button",
                                onPressed: () {},
                                iconData: Icons.person_add_alt_1,
                              )
                            ],
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
        Future.delayed(Duration(seconds: 3), () {
          if (context.mounted) {
            context.read<SearchUserBloc>().add(SearchUserReset());
          }
        });
        return Text(state.errMsg.toString());
      }
      return SizedBox.shrink();
    });
  }
}
