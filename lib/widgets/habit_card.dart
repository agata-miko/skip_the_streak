import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skip_the_streak/cubits/hive_state.dart';
import 'package:skip_the_streak/models/habit.dart';
import 'package:skip_the_streak/screens/edit_habit_screen.dart';
import '../cubits/hive_cubit.dart';
import 'congrats_dialog.dart';

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
        builder: (context) {
          return AlertDialog(
            title: Text(card.title.toUpperCase()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                card.description != null
                    ? Text(
                        card.description!,
                        style: const TextStyle(fontSize: 15),
                      )
                    : const Text(
                        'No details, you\'re good to go!',
                      ),
                if (card.startDate != null)
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                if (card.startDate != null)
                  Text(
                    'Start date: ${DateFormat('dd MMMM yyyy').format(card.startDate!)}',
                    style: const TextStyle(fontSize: 15),
                  ),
                if (card.milestone != null && card.milestone != 0)
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                if (card.milestone != null && card.milestone != 0)
                  Text(
                    'Milestone: ${card.milestone!}',
                    style: const TextStyle(fontSize: 15),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Got it!'),
              ),
            ],
          );
        });
  }

  void _showCongratulationsDialog(BuildContext context) {
    // Show the congratulations dialog when the milestone is achieved
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CongratulationsDialog(habitNumber: card.number + 1,);
      },
    );
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
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.read<HiveCubit>().incrementHabitNumber(habitId);
        if (card.milestone != null && (card.number + 1) % card.milestone! == 0) {
          _showCongratulationsDialog(context);
        }
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
                      color: Colors
                          .white, // Make sure text is visible on the image
                    ),
                    maxLines: 3,
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
                          color: Colors
                              .white, // Make sure text is visible on the image
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    PopupMenuButton<String>(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors
                            .white, // Change icon color to match the overlay
                      ),
                      onSelected: (value) {},
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'reverse',
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_circle_left_outlined),
                                const Text(' Reverse the tap '),
                              ],
                            ),
                            onTap: () {
                              context.read<HiveCubit>().decrementHabitNumber(habitId);
                            },
                          ),
                          PopupMenuItem<String>(
                            value: 'details',
                            child: const Text('Details'),
                            onTap: () {
                              _showDetailsDialog(context);
                              print(card.milestone);
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
