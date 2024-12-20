import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skip_the_streak/models/habit.dart';
import 'package:skip_the_streak/dummy_data/dummy_data.dart';
import 'package:skip_the_streak/screens/edit_habit_screen.dart';

import '../cubits/hive_cubit.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.card,
    required this.habitId,
  });

  final Habit card;
  final String habitId;

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text(
                  'Are you sure you want to remove this habit? This cannot be undone.'),
              actions: [
                TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
                TextButton(onPressed: () {context.read<HiveCubit>().deleteHabit(habitId); Navigator.of(context).pop();}, child: Text('Remove habit'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    // Define dynamic sizes
    final double fontSizeTitle = screenWidth * 0.04;
    final double fontSizeBody = screenWidth * 0.035;
    final double fontSizeNumber = screenWidth * 0.05;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                card.imagePath,
                height: MediaQuery.of(context).size.height * 0.11,
                width: MediaQuery.of(context).size.height * 0.11,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              card.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSizeTitle,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: card.description != null
                ? Text(
                    card.description!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSizeBody,
                    ),
                    maxLines: 1,
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${card.number}',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: fontSizeNumber,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditHabitScreen()));
                        },
                      ),
                      PopupMenuItem<String>(
                        value: 'remove',
                        child: Text('Remove'),
                        onTap: () {_showDialog(context);},
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
