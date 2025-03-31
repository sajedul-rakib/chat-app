import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/custom_snackbar.dart';

class StorySection extends StatelessWidget {
  const StorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => CustomSnackbar.show(
                    context: context,
                    message: "Update will latter"),
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary,
                      )),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.plus,
                      size: 30,
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary,
                    ),
                  ),
                ),
              ),
              Text(
                "Your Story",
                style: TextStyle(
                    fontSize: 14,
                    color:
                    Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}