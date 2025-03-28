import 'dart:developer';

import 'package:chat_app/features/signup/presentation/widget/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/add_friend_dialog.dart';
import '../widgets/friend_list_tile.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  final TextEditingController _friendGmailETController =
      TextEditingController();
  final TextEditingController _searcETController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          InkWell(
              onTap: () => addFriendDialog(context, _friendGmailETController),
              child: const Icon(CupertinoIcons.plus)),
          const SizedBox(
            width: 20,
          )
        ],
        title: const Text(
          "Contacts",
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputFormField(
                hintText: 'Search',
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 15,
                  ),
                ),
                textEditionController: _searcETController,
                onChange: (value) {
                  log(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (_, index) {
                  // return const FriendListTile(
                  //   conversation:null,
                  // );
                },
                separatorBuilder: (_, int index) {
                  return const Divider();
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
