import 'package:flutter/material.dart';
import 'package:skip_the_streak/models/habit.dart';
import 'package:skip_the_streak/dummy_data/dummy_data.dart';

class HabitCard extends StatelessWidget {

  const HabitCard({
    super.key,
    required this.card,
  });

  final Habit card;


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    // Define dynamic sizes
    final double fontSizeTitle = screenWidth * 0.04;
    final double fontSizeBody = screenWidth * 0.035;
    final double fontSizeNumber = screenWidth * 0.05;

    return Card(
      elevation: 4,
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
            child: Image.network(
              card.imagePath,
              height: MediaQuery.of(context).size.height * 0.17,
              width: double.infinity,
              fit: BoxFit.cover,
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
            child: card.description != null ? Text(
              card.description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSizeBody,
              ),
              maxLines: 1,
            ) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${card.number}',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: fontSizeNumber,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
