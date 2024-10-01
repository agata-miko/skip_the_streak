import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skip_the_streak/dummy_data/dummy_data.dart';
import 'package:skip_the_streak/screens/add_habit_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/habit_card.dart';

class MainHabitsScreen extends StatefulWidget {
  MainHabitsScreen({super.key});

  @override
  State<MainHabitsScreen> createState() => _MainHabitsScreenState();
}

class _MainHabitsScreenState extends State<MainHabitsScreen> {

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
          leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.settings), // Settings icon
                  onPressed: () {
                    // Open the drawer when settings icon is tapped
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddHabitScreen()));},
            ),
          ],
        ),
        drawer: AppDrawer(context: context),
        body: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: screenWidth * 0.04,
              //       vertical: screenSize.height * 0.02),
              //   child: Text(
              //     'Hello $dayOfWeek',
              //     style: TextStyle(
              //       fontSize: 24, // Match the updated 'New habit' size
              //       color: Theme.of(context).colorScheme.primary,
              //       fontWeight: FontWeight.bold, // Same weight as 'New habit'
              //       letterSpacing: 0.8, // Same letter spacing for consistency
              //       height: 1.4, // Line height for better vertical spacing
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: screenSize.height * 0.02,
              // ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    crossAxisSpacing: cardPadding, // Space between columns
                    mainAxisSpacing: cardPadding, // Space between rows
                    childAspectRatio: 1,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return HabitCard(card: card);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
