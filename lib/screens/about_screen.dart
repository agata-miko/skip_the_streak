import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(color: Color(0xff49672d)),
            child: const Column(
              children: [
                Text(
                  'What is Skip the Streak all about?'
                ),
                Text('Forget the pressure of keeping a perfect streak. It\'s simple: focus on action, not perfection.Track your habits, celebrate your progress, and take it one day at a time. Enjoy the small wins without the stress.')
              ],
            ),
            ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'lib/assets/images/about_image.png',
              fit: BoxFit.cover,
            )),
      ]),
    );
  }
}
