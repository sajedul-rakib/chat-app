import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../signup/presentation/widget/text_form_field.dart';
import '../../../splash/presentation/widgets/app_button.dart';

Future<dynamic> addFriendDialog(
    BuildContext context, TextEditingController friendGmailETController) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add new friend",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(FontAwesomeIcons.xmark),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputFormField(
                    hintText: "Enter friend gmail or name",
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Icon(
                        FontAwesomeIcons.person,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 15,
                      ),
                    ),
                    textEditionController: friendGmailETController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                    buttonTitle: "Search",
                    iconData: FontAwesomeIcons.magnifyingGlass,
                    onPressed: () {
                      log("Search");
                      // CustomSnackBar.customSnackBar(context, 'Success');
                    },
                  )
                ],
              ),
            ),
          ),
        );
      });
}
