import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:flutter/material.dart';
//app bar

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';
import '../../../widgets/custom_snackbar.dart';
import './show_profile_pic.dart';

PreferredSizeWidget conversationAppBar(BuildContext context, User user) {
  return AppBar(
    elevation: 10,
    title: InkWell(
      onTap: () {
        user.profilePic != null && user.profilePic!.isNotEmpty
            ? showProfilePic('${dotenv.env['BASE_URL']}${user.profilePic!}',
                user.fullName!, user.email!, context)
            : null;
      },
      child: Row(
        children: [
          BlocBuilder<OnlineUserBloc, OnlineUserState>(
            builder: (context, state) {
              bool isOnline = false;
              if (state is OnlineUsersUpdated) {
                isOnline = state.onlineUser.contains(user.sId);
              }

              return Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 3, color: isOnline ? Colors.green : Colors.red),
                    shape: BoxShape.circle),
                child: CircleAvatar(
                    backgroundImage:
                        user.profilePic != null && user.profilePic!.isNotEmpty
                            ? NetworkImage(
                                '${dotenv.env['BASE_URL']}${user.profilePic!}')
                            : user.gender == 'female'
                                ? AssetImage('assets/images/female.jpg')
                                : AssetImage('assets/images/man.jpg')),
              );
            },
          ),
          const SizedBox(width: 6),
          Text(
            user.fullName ?? " ",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    ),
    actions: [
      _buildAppBarAction(
          FontAwesomeIcons.phone, "It's will update later", context),
      const SizedBox(
        width: 20,
      ),
      _buildAppBarAction(
          FontAwesomeIcons.video, "It's will update later", context),
      const SizedBox(
        width: 20,
      ),
    ],
  );
}

Widget _buildAppBarAction(IconData icon, String message, BuildContext context) {
  return InkWell(
    onTap: () => CustomSnackbar.show(context: context, message: message),
    child: Icon(icon),
  );
}
