import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
    this.leadingIcon,
    this.trailingWidgets,
    required this.title,
    this.onPressed,
  });

  final IconData? leadingIcon;
  final Widget? trailingWidgets;
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(leadingIcon),
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
