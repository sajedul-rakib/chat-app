import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:flutter/material.dart';

class FriendListTile extends StatelessWidget {
  const FriendListTile(
      {super.key,
      this.onPressed,
      required this.user,
      required this.lastMessage});

  final Function()? onPressed;
  final User user;
  final String? lastMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          CircleAvatar(
              backgroundImage:
                  user.profilePic != null && user.profilePic!.isNotEmpty
                      ? NetworkImage(user.profilePic!)
                      : user.gender == 'female'
                          ? AssetImage('assets/images/female.jpg')
                          : AssetImage('assets/images/man.jpg')),
          Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2),
                shape: BoxShape.circle,
                color: user.status != null
                    ? user.status == 'online'
                        ? const Color(0xff2CC069)
                        : const Color(0xfff54d4d)
                    : null),
          )
        ],
      ),
      title: Text(user.fullName ?? ''),
      subtitle: Text(lastMessage ?? ""),
    );
  }
}
