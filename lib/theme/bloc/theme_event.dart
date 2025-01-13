part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class InitialTheme extends ThemeEvent {}

final class ThemeModeChanged extends ThemeEvent {
  final String themeMode;
  const ThemeModeChanged({required this.themeMode});
}
