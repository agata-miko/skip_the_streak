import 'package:flutter/material.dart';
import 'package:skip_the_streak/constants/congrats_slogans.dart';

class CongratulationsDialog extends StatelessWidget {

  const CongratulationsDialog({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Copy the slogans list and shuffle it
    final slogansList = List<String>.from(encouragingSlogans);
    slogansList.shuffle();  // Shuffle the copy of the list

    // Randomly pick a congratulatory slogan from the shuffled list
    final randomSlogan = slogansList.first;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          // Text Overlay with a congratulatory message
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    randomSlogan,  // Displaying a random slogan
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Thank You!'),
        ),
      ],
    );
  }
}
