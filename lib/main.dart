import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:skip_the_streak/screens/about_screen.dart';
import 'package:skip_the_streak/screens/add_habit_screen.dart';
import 'package:skip_the_streak/screens/edit_habit_screen.dart';
import 'package:skip_the_streak/screens/login_screen.dart';
import 'package:skip_the_streak/screens/main_habits_screen.dart';
import 'package:skip_the_streak/screens/register_screen.dart';
import 'package:skip_the_streak/screens/reminder_screen.dart';
import 'package:skip_the_streak/screens/welcome_screen.dart';
import 'package:skip_the_streak/widgets/habit_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils/util.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Assistant", "Assistant");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: WelcomeScreen(),
    );
  }
}
