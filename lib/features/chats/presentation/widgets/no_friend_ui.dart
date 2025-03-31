import 'package:flutter/material.dart';

import '../../../contacts/presentation/widgets/add_friend_dialog.dart';
import '../../../splash/presentation/widgets/app_button.dart';

class NoFriendUi extends StatelessWidget {
  const NoFriendUi({
    super.key,
    required TextEditingController friendGmailETController,
  }) : _friendGmailETController = friendGmailETController;

  final TextEditingController _friendGmailETController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Text("No friends found",
            style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary,
                fontSize: 20)),
        SizedBox(
          width: 180,
          child: AppButton(
              buttonTitle: "Add Friend",
              onPressed: () {
                addFriendDialog(
                    context, _friendGmailETController);
              }),
        )
      ],
    );
  }
}