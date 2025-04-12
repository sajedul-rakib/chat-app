import 'package:chat_app/router/route_name.dart';
import 'package:flutter/material.dart';

import '../../../splash/presentation/widgets/app_button.dart';

class NoFriendUi extends StatelessWidget {
  const NoFriendUi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Text("No friends found",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 20)),
        SizedBox(
          width: 180,
          child: AppButton(
              buttonTitle: "Add Friend",
              onPressed: () {
                Navigator.pushNamed(context, RouteName.addFriend);
              }),
        )
      ],
    );
  }
}
