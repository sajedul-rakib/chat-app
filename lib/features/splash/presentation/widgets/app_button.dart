import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.onPressed,
      this.iconData,
      required this.buttonTitle,
      this.backgroundColor});

  final Function()? onPressed;
  final IconData? iconData;
  final String buttonTitle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: WidgetStatePropertyAll(backgroundColor)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(0xffF7F7FC),
              ),
            ),
            if (iconData != null)
              const SizedBox(
                width: 10,
              ),
            if (iconData != null)
              Icon(
                iconData,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
