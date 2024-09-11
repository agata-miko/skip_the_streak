import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:skip_the_streak/screens/about_screen.dart';
import 'package:skip_the_streak/screens/login_screen.dart';
import 'package:skip_the_streak/widgets/habit_card.dart';
import 'generated/l10n.dart';
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
    localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
   ],
      supportedLocales: [
        Locale('en'), // English
        Locale('pl'), // Spanish
      ],
      home: LoginScreen(),
    );
  }
}


