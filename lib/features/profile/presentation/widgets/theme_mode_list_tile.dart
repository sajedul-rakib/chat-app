import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/bloc/theme_bloc.dart';
import 'menu_list.dart';

class ThemeModeListTile extends StatelessWidget {
  const ThemeModeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MenuList(
        leadingIcon: state.themeType == ThemeType.dark
            ? Icons.dark_mode
            : state.themeType == ThemeType.light
                ? Icons.light_mode
                : Icons.bookmark_outline,
        title:
            "Appearance - ${state.themeType == ThemeType.dark ? "Dark" : state.themeType == ThemeType.light ? "Light" : "System"}",
        trailingWidgets: PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: 'Light',
                onTap: () => BlocProvider.of<ThemeBloc>(context)
                    .add(const ThemeModeChanged(themeMode: 'light')),
                child: MenuList(
                  title: 'Light',
                  trailingWidgets: Visibility(
                      visible: state.themeType == ThemeType.light,
                      child: const Icon(Icons.check)),
                )),
            PopupMenuItem(
                onTap: () {
                  context
                      .read<ThemeBloc>()
                      .add(ThemeModeChanged(themeMode: 'dark'));
                },
                value: 'Dark',
                child: MenuList(
                  title: 'Dark',
                  trailingWidgets: Visibility(
                      visible: state.themeType == ThemeType.dark,
                      child: const Icon(Icons.check)),
                )),
            PopupMenuItem(
                onTap: () => BlocProvider.of<ThemeBloc>(context)
                    .add(const ThemeModeChanged(themeMode: 'system')),
                value: 'System',
                child: MenuList(
                  title: 'System',
                  trailingWidgets: Visibility(
                      visible: state.themeType == ThemeType.system,
                      child: const Icon(Icons.check)),
                ))
          ];
        }),
      );
    });
  }
}
