import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // **<--- New import for Bloc**
import '../cubits/hive_cubit.dart'; // **<--- New import for HiveCubit**
import 'package:skip_the_streak/screens/add_habit_screen.dart';
import '../cubits/hive_state.dart';
import 'settings_screen.dart';
import '../widgets/habit_card.dart';

class MainHabitsScreen extends StatefulWidget {
  MainHabitsScreen({super.key});

  @override
  State<MainHabitsScreen> createState() => _MainHabitsScreenState();
}

class _MainHabitsScreenState extends State<MainHabitsScreen> {
  @override
  void initState() {
    super.initState();
    // Load habits when the screen is initialized
    context
        .read<HiveCubit>()
        .loadHabits(); // Assuming you have a loadHabits method in your HiveCubit
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final dayOfWeek = DateFormat('EEEE', locale).format(DateTime.now());

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final double cardPadding = screenWidth * 0.01;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Builder(
            builder: (BuildContext context) {
              final locale = Localizations.localeOf(context).toString(); // Get current locale
              final now = DateTime.now(); // Current date
              final dayOfWeek = DateFormat('EEEE', locale).format(now); // Localized day
              final date = DateFormat('dd MMMM', locale).format(now); // Localized date
              final titleText = '$dayOfWeek $date'; // Combine day and date

              return Text(titleText); // Display the localized title
            },
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.settings), // Settings icon
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Allows for full-height modals
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20)), // Rounded corners for the modal
                      ),
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FractionallySizedBox(
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
                      return Center(
                          child:
                              CircularProgressIndicator()); // **<--- Show loading indicator while loading**
                    } else if (state is HiveLoaded) {
                      final habits =
                          state.habits; // **<--- Get habits from state**
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // Two columns
                          crossAxisSpacing: cardPadding,
                          // Space between columns
                          mainAxisSpacing: cardPadding,
                          // Space between rows
                          childAspectRatio: 1,
                        ),
                        itemCount: habits.length,
                        // **<--- Use the number of habits**
                        itemBuilder: (context, index) {
                          final habit =
                              habits[index]; // **<--- Get each habit**
                          return HabitCard(
                              card:
                                  habit); // **<--- Pass the habit to the HabitCard**
                        },
                      );
                    } else if (state is HiveError) {
                      return Center(
                          child: Text(
                              'Failed to load habits')); // **<--- Show error message**
                    }
                    return Center(
                        child: Text(
                            'No habits found')); // **<--- Default message if no habits**
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Allows for full-height modals
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20)), // Rounded corners for the modal
              ),
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FractionallySizedBox(
                    heightFactor: 0.9, // Use 90% of the screen height
                    child: AddHabitScreen(),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
