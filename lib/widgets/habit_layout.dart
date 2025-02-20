import 'package:flutter/material.dart';
import '../models/habit.dart';
import 'habit_card.dart';

class HabitLayout extends StatelessWidget {
  final List<Habit> habits;

  const HabitLayout({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    if (habits.length == 1) {
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 1.5,
          child: HabitCard(card: habits[0], habitId: habits[0].id),
        ),
      );
    } else if (habits.length >= 2 && habits.length <=3) {
      return Column(
        children: habits
            .map((habit) => Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: HabitCard(card: habit, habitId: habit.id),
          ),
        ))
            .toList(),
      );
    }
    else if (habits.length == 4) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.52,
        ),
        itemCount: habits.length,
        itemBuilder: (context, index) => HabitCard(
          card: habits[index],
          habitId: habits[index].id,
        ),
      );
      } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: habits.length,
        itemBuilder: (context, index) => HabitCard(
          card: habits[index],
          habitId: habits[index].id,
        ),
      );
    }
  }
}


