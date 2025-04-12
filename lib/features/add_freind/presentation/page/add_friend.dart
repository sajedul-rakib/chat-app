import 'package:chat_app/features/add_freind/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:chat_app/features/add_freind/presentation/widget/user_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../signup/presentation/widget/text_form_field.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final TextEditingController _friendGmailETController =
      TextEditingController();

  @override
  void dispose() {
    _friendGmailETController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, obj) {
        if (didPop) {
          context.read<SearchUserBloc>().add(SearchUserReset());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Friend"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              InputFormField(
                  hintText: "Search friend with name or email",
                  textEditionController: _friendGmailETController,
                  onChange: (v) {
                    if (v.isNotEmpty) {
                      context
                          .read<SearchUserBloc>()
                          .add(SearchFriendRequestRequired(keyword: v));
                    } else {
                      context.read<SearchUserBloc>().add(SearchUserReset());
                    }
                  }),
              const SizedBox(height: 10,),
              Expanded(child: UserSearchResult())
            ],
          ),
        ),
      ),
    );
  }
}
