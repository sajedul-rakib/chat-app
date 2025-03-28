import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/shared/theme_shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState.system()) {
    on<InitialTheme>((event, emit) async {
      String? themeMode = await ThemeShared.getTheme();
      if (themeMode != null) {
        log('log from theme bloc $themeMode');
        if (themeMode == 'light') {
          emit(ThemeState.light(themeMode: ThemeMode.light));
        } else if (themeMode == 'dark') {
          emit(ThemeState.dark(themeMode: ThemeMode.dark));
        } else {
          emit(ThemeState.system());
        }
      } else {
        emit(ThemeState.system());
      }
    });
    on<ThemeModeChanged>((event, emit) {
      if (event.themeMode == 'dark') {
        emit(const ThemeState.dark(themeMode: ThemeMode.dark));
      } else if (event.themeMode == 'light') {
        emit(const ThemeState.light(themeMode: ThemeMode.light));
      } else {
        emit(const ThemeState.system());
      }
      //save the theme mode to shared preference
      ThemeShared.setThemeMode(event.themeMode);
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
