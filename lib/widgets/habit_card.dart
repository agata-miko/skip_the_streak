import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skip_the_streak/models/habit.dart';
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
          title: const Text('Are you sure?'),
          content: const Text(
              'Are you sure you want to remove this habit? This cannot be undone.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  context.read<HiveCubit>().deleteHabit(habitId);
                  Navigator.of(context).pop();
                },
                child: const Text('Remove habit'))
          ],
        ));
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Details'),
          content: card.description != null
              ? Text(
            card.description!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          )
              : Text('No details, you\'re good to go!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Great!')),
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

    return InkWell(
      onTap: () {
        context.read<HiveCubit>().incrementHabitNumber(habitId);
      },
      child: Card(
        margin: EdgeInsets.all(4),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  card.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content overlay
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    card.title.toUpperCase(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white, // Make sure text is visible on the image
                    ),
                    maxLines: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        '${card.number}',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          color: Colors.white, // Make sure text is visible on the image
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white, // Change icon color to match the overlay
                      ),
                      onSelected: (value) {},
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'details',
                            child: const Text('Details'),
                            onTap: () {
                              _showDetailsDialog(context);
                            },
                          ),
                          PopupMenuItem<String>(
                            value: 'edit',
                            child: const Text('Edit'),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                      bottom: Radius.zero),
                                ),
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FractionallySizedBox(
                                      heightFactor: 0.9,
                                      child: EditHabitScreen(habit: card),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          PopupMenuItem<String>(
                            value: 'remove',
                            child: const Text('Remove'),
                            onTap: () {
                              _showDialog(context);
                            },
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
