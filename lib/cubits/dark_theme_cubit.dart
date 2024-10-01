import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:skip_the_streak/theme/theme.dart';

//TODO pass the users choice to the db to ensure app remembers it between usages

class ThemeState {
  final bool isDarkMode;
  const ThemeState({required this.isDarkMode});
}
class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit() : super(const ThemeState(isDarkMode: false));

  void toggleTheme(bool isDarkMode) {
    emit(ThemeState(isDarkMode: !state.isDarkMode));
  }
}