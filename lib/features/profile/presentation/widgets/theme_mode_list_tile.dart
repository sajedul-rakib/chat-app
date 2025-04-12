import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/bloc/theme_bloc.dart';

class ThemeModeListTile extends StatelessWidget {
  const ThemeModeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return ListTile(
        leading: Icon(state.themeType == ThemeType.dark
            ? Icons.dark_mode
            : state.themeType == ThemeType.light
                ? Icons.light_mode
                : Icons.settings),
        title: Text(
            "Appearance - ${state.themeType == ThemeType.dark ? "Dark" : state.themeType == ThemeType.light ? "Light" : "System"}",style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w700)),
        trailing: PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: 'Light',
                onTap: () => BlocProvider.of<ThemeBloc>(context)
                    .add(const ThemeModeChanged(themeMode: 'light')),
                child: ListTile(
                  title: Text(
                    "Light",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  trailing: Visibility(
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
                child: ListTile(
                  title: Text(
                    "Dark",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  trailing: Visibility(
                      visible: state.themeType == ThemeType.dark,
                      child: const Icon(Icons.check)),
                )),
            PopupMenuItem(
                onTap: () => BlocProvider.of<ThemeBloc>(context)
                    .add(const ThemeModeChanged(themeMode: 'system')),
                value: 'System',
                child: ListTile(
                  title: Text(
                    "System",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700,fontSize: 15),
                  ),
                  trailing: Visibility(
                      visible: state.themeType == ThemeType.system,
                      child: const Icon(Icons.check)),
                ))
          ];
        }),
      );
    });
  }
}
