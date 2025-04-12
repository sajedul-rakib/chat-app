import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
    this.leadingWidget,
    this.trailingWidgets,
    required this.title,
    this.onPressed,
  });

  final Widget? leadingWidget;
  final Widget? trailingWidgets;
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed ??
          () {
            CustomSnackbar.show(
                context: context, message: "Update will latter");
          },
      leading: leadingWidget,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w700),
      ),
      trailing: trailingWidgets,
    );
  }
}
