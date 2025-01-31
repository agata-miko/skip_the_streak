import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skip_the_streak/screens/congrats_screen.dart';
import 'package:skip_the_streak/screens/main_habits_screen.dart';
import 'package:skip_the_streak/screens/welcome_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'adapters/habit_adapter.dart';
import 'cubits/carousel_cubit.dart';
import 'cubits/dark_theme_cubit.dart';
import 'cubits/hive_cubit.dart';
import 'cubits/language_cubit.dart';
import 'cubits/milestone_cubit.dart';
import 'cubits/reminder_cubit.dart';
import 'cubits/start_date_cubit.dart';
import 'models/habit.dart';
import 'utils/util.dart';
import 'theme/theme.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(HabitAdapter()); // Register the Habit adapter
  var habitBox = await Hive.openBox<Habit>('habits'); // Open the Hive box

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<ReminderCubit>(
        create: (context) => ReminderCubit(),
      ),
        BlocProvider(
          create: (context) => HiveCubit(habitBox), // Pass the opened box to HiveCubit
        ),
        BlocProvider<CarouselCubit>(
          create: (context) => CarouselCubit(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Assistant", "Assistant");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => StartDateCubit()),
        BlocProvider(create: (context) => MilestoneCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
        return BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
          return MaterialApp(
            theme: themeState.isDarkMode ? theme.dark() : theme.light(),
            title: 'Skip the Streak',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            home: const MainHabitsScreen(),
          );},
        );},
      ),
    );
  }
}
