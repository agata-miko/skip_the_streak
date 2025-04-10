import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int currentIndex = 0;

  void nextStory(int total) {
    if (currentIndex < total - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousStory() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final stories = [
      AppLocalizations.of(context)!.about1,
      'Forget the pressure of keeping a perfect streak. It\'s simple: focus on action, not perfection.',
      'Track your habits, celebrate your progress, and take it one day at a time. Enjoy the small wins without the stress. 💙',
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (details) {
          if (details.globalPosition.dx < screenWidth / 2) {
            previousStory();
          } else {
            nextStory(stories.length);
          }
        },
        child: Stack(
          children: [
            // Main content (story text)
            Center(
              child: Text(
                stories[currentIndex],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28),
              ),
            ),

            // Progress bar at the bottom
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Row(
                children: List.generate(stories.length, (index) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 4,
                      decoration: BoxDecoration(
                        color: index <= currentIndex
                            ? Colors.black26
                            : Colors.black12,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
