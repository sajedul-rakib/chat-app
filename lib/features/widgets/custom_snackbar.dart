import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(
      {required BuildContext context, required String message, Color? backgroundColor}) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.secondary,
      content: Text(message,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSecondary)),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
