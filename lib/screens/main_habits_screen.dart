import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/hive_cubit.dart';
import 'package:skip_the_streak/screens/add_habit_screen.dart';
import '../cubits/hive_state.dart';
import '../models/habit.dart';
import '../widgets/habit_layout.dart';
import 'settings_screen.dart';
import '../widgets/habit_card.dart';

class MainHabitsScreen extends StatefulWidget {
  const MainHabitsScreen({super.key});

  @override
  State<MainHabitsScreen> createState() => _MainHabitsScreenState();
}

class _MainHabitsScreenState extends State<MainHabitsScreen> {

  //TEST TEST TEST
  void printHabitsFromHive() {
    final habitBox = Hive.box<Habit>('habits');  // Otwórz odpowiedni Box

    // Wydrukuj wszystkie habit
    habitBox.values.forEach((habit) {
      print('Habit ID: ${habit.id}, Title: ${habit.title}, Milestone: ${habit.milestone}');
    });
  }
 // TEST TEST TEST
  @override
  void initState() {
    super.initState();
    context.read<HiveCubit>().loadHabits();
    context.read<HiveCubit>().initializeWithDummyHabit();
    // TEST TEST TEST
    printHabitsFromHive();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final double cardPadding = screenWidth * 0.01;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          title: Builder(
            builder: (BuildContext context) {
              final locale = Localizations.localeOf(context)
                  .toString(); // Get current locale
              final now = DateTime.now(); // Current date
              final dayOfWeek =
                  DateFormat('EEEE', locale).format(now); // Localized day
              final date =
                  DateFormat('dd MMMM', locale).format(now); // Localized date
              final titleText = '$dayOfWeek'; // Combine day and date

              return Text('$titleText'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        // Apply the theme's TextStyle
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: Colors.black54,
                      )); // Display the localized title
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Allows for full-height modals
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                          bottom: Radius.zero), // Rounded corners for the modal
                    ),
                    builder: (BuildContext context) {
                      return const ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20), bottom: Radius.zero),
                        child: FractionallySizedBox(
                          heightFactor: 0.9, // Use 90% of the screen height
                          child: AddHabitScreen(),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.add_circle,
                  size: 40,
                  color: Colors.black54,
                )),
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.black54,
                  ),
                  // Settings icon
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Allows for full-height modals
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom:
                                Radius.zero), // Rounded corners for the modal
                      ),
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const FractionallySizedBox(
                            heightFactor: 0.9, // Use 90% of the screen height
                            child: SettingsScreen(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
          toolbarHeight: 80,
        ),
        body: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocBuilder<HiveCubit, HiveState>(
                  // **<--- Using BlocBuilder to listen for state changes**
                  builder: (context, state) {
                    if (state is HiveLoading) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // **<--- Show loading indicator while loading**
                    } else if (state is HiveLoaded) {
                      final habits =
                          state.habits; // **<--- Get habits from state**
                      return BlocBuilder<HiveCubit, HiveState>(
                        builder: (context, state) {
                          if (state is HiveLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is HiveLoaded) {
                            return HabitLayout(habits: state.habits);
                          } else if (state is HiveError) {
                            return const Center(
                                child: Text('Failed to load habits'));
                          }
                          return const Center(child: Text('No habits found'));
                        },
                      );
                    } else if (state is HiveError) {
                      return const Center(
                          child: Text(
                              'Failed to load habits')); // **<--- Show error message**
                    }
                    return const Center(
                        child: Text(
                            'No habits found')); // **<--- Default message if no habits**
                  },
                ),
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   shape: const CircleBorder(),
        //   backgroundColor: Color(0xFFE7AC15),
        //   onPressed: () {
        //     showModalBottomSheet(
        //       context: context,
        //       isScrollControlled: true, // Allows for full-height modals
        //       shape: const RoundedRectangleBorder(
        //         borderRadius: BorderRadius.vertical(
        //             top: Radius.circular(20), bottom: Radius.zero), // Rounded corners for the modal
        //       ),
        //       builder: (BuildContext context) {
        //         return const ClipRRect(
        //           borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.zero),
        //           child: FractionallySizedBox(
        //             heightFactor: 0.9, // Use 90% of the screen height
        //             child: AddHabitScreen(),
        //           ),
        //         );
        //       },
        //     );
        //   },
        //   child: const Icon(Icons.add),
        // ),
        // // bottomNavigationBar: BottomAppBar(
        // //   shape: const CircularNotchedRectangle(),
        // //   child: SizedBox(height: 50,),
        // // ),
      ),
    );
  }
}
