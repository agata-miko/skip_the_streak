import 'package:flutter/material.dart';
import 'package:skip_the_streak/models/habit.dart';

class HabitCard extends StatelessWidget {
  // final Habit habit;
  // const HabitCard({super.key, required this.habit}); //to be added later

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth / 2) - 16;

    return Container(
      color: Colors.yellow,
      width: cardWidth,
      padding: const EdgeInsets.all(8),
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'lib/assets/images/login_screen.png',
                  fit: BoxFit.cover,
                )),
            const SizedBox(height: 14),
            const Text('Title placeholder'),
            const Text('100'),
            const Text('Start date: 05/09/2024')
          ],
        ),
      ),
    );
  }
}
