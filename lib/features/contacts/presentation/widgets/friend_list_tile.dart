import 'dart:developer';

import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FriendListTile extends StatelessWidget {
  const FriendListTile({
    super.key,
    this.onPressed,
    required this.user,
    required this.lastMessage,
  });

  final Function()? onPressed;
  final User user;
  final String? lastMessage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnlineUserBloc, OnlineUserState>(
      builder: (context, state) {
        bool isOnline = false;

        if (state is OnlineUsersUpdated) {
          log(state.onlineUser.toString());
          isOnline = state.onlineUser[user.sId] ?? false;
        }

        return ListTile(
          onTap: onPressed,
          leading: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              CircleAvatar(
                backgroundImage: user.profilePic != null &&
                    user.profilePic!.isNotEmpty
                    ? NetworkImage('${dotenv.env['BASE_URL']}${user.profilePic!}')
                    : user.gender == 'female'
                    ? const AssetImage('assets/images/female.jpg')
                as ImageProvider
                    : const AssetImage('assets/images/man.jpg')
                as ImageProvider,
              ),
              Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: isOnline
                      ? const Color(0xff2CC069) // Online (Green)
                      : const Color(0xfff54d4d), // Offline (Red)
                ),
              )
            ],
          ),
          title: Text(user.fullName ?? ''),
          subtitle: Text(
            lastMessage ?? "",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
