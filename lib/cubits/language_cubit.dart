import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//TODO pass the locale to db to ensure app remembers the user's choice

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  void changeLanguage(Locale locale) {
    emit(locale);
  }
}
