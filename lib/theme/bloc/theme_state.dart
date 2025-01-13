part of 'theme_bloc.dart';

enum ThemeType { light, dark, system }

final class ThemeState extends Equatable {
  final ThemeType themeType;

  const ThemeState._({this.themeType = ThemeType.system});

  //system theme state
  const ThemeState.system() : this._();

  //light theme state
  const ThemeState.light({ThemeMode? themeMode})
      : this._(themeType: ThemeType.light);

  //dark theme state
  const ThemeState.dark({ThemeMode? themeMode})
      : this._(themeType: ThemeType.dark);

  @override
  List<Object> get props => [themeType];
}
