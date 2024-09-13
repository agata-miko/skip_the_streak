import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skip_the_streak/dummy_data/dummy_data.dart';
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
    final double fontSizeTitle = screenWidth * 0.04;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello $dayOfWeek',
                style: TextStyle(
                    fontSize: 28,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    crossAxisSpacing: cardPadding, // Space between columns
                    mainAxisSpacing: cardPadding, // Space between rows
                    childAspectRatio: 0.7,
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
