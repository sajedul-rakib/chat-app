import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:flutter/material.dart';

class FriendListTile extends StatelessWidget {
  const FriendListTile({
    super.key,
    this.onPressed,
    required this.user,
  });

  final Function()? onPressed;
  final User user;

  @override
  Widget build(BuildContext context) {
    log(jsonEncode(user.toJson()));
    return ListTile(
      onTap: onPressed,
      leading: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          user.profilePic != null &&
                 user.profilePic!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.profilePic!))
              : Image.asset('assets/images/user.png'),
          Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2),
                shape: BoxShape.circle,
                color: const Color(0xff2CC069)),
          )
        ],
      ),
      title: Text(user.fullName ?? ''),
      subtitle: const Text("Last seen yestarday"),
    );
  }
}
