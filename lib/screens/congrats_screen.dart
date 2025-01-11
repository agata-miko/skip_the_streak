import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key});

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play(); // Automatically play the confetti

    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.of(context).pop(); // Navigate back or close the screen
      }
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false, // Play for the duration and stop
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
                maxBlastForce: 100,
                minBlastForce: 1,
                numberOfParticles: 400, // Increased number of particles
                emissionFrequency: 0.05,
                createParticlePath: getRandomShape,// Higher frequency for more particles
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Congrats!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Path getRandomShape(Size size) {
    final shapes = [drawStar, drawCircle, drawHeart];
    final random = Random();
    return shapes[random.nextInt(shapes.length)]();
  }

  /// Star shape
  Path drawStar() {
    double radius = 10.0;
    const int numPoints = 5;
    final double innerRadius = radius / 2.5;

    Path path = Path();
    double angle = (2 * pi) / numPoints;

    for (int i = 0; i < numPoints; i++) {
      double outerX = radius * cos(i * angle);
      double outerY = radius * sin(i * angle);
      path.lineTo(outerX, outerY);

      double innerX = innerRadius * cos((i + 0.5) * angle);
      double innerY = innerRadius * sin((i + 0.5) * angle);
      path.lineTo(innerX, innerY);
    }
    path.close();
    return path;
  }

  /// Circle shape
  Path drawCircle() {
    Path path = Path();
    path.addOval(Rect.fromCircle(center: Offset(0, 0), radius: 5.0));
    return path;
  }

  /// Heart shape
  Path drawHeart() {
    Path path = Path();
    path.moveTo(0, -5);
    path.cubicTo(-6, -12, -12, -5, 0, 6);
    path.cubicTo(12, -5, 6, -12, 0, -5);
    path.close();
    return path;
  }
}

