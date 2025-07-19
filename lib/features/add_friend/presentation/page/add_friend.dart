import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../signup/presentation/widget/text_form_field.dart';
import '../bloc/search_user_bloc/search_user_bloc.dart';
import '../widget/user_search_result.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  late final TextEditingController _friendGmailETController;

  Timer? _debounce;

  @override
  void initState() {
    _friendGmailETController = TextEditingController();
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.trim().isNotEmpty) {
        context.read<SearchUserBloc>().add(
              SearchFriendRequestRequired(keyword: query.trim()),
            );
      } else {
        context.read<SearchUserBloc>().add(SearchUserReset());
      }
    });
  }

  @override
  void dispose() {
    _friendGmailETController.dispose();
    _debounce?.cancel();
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
                  onChange: _onSearchChanged),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: UserSearchResult())
            ],
          ),
        ),
      ),
    );
  }
}
