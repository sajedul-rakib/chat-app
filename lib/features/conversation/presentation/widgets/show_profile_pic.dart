import 'package:flutter/material.dart';

//show the profile pic of the friend and his/her name and email
void showProfilePic(
    String profilePicUrl, String fullName, String mail, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                image: DecorationImage(
                  image: NetworkImage(profilePicUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              fullName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              mail,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      );
    },
  );
}
