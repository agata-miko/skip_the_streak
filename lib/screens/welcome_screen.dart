import 'package:flutter/material.dart';
import 'package:skip_the_streak/screens/main_habits_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _imageAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define varied animations for each image with different placements
    _imageAnimations = [
      Tween<Offset>(
        begin: const Offset(2.0, -4.0), // Top left
        end: const Offset(0.1, -0.5), // Adjusted for better visibility
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )),
      Tween<Offset>(
        begin: const Offset(2.0, -1.5), // Top right
        end: const Offset(0.8, -1.7), // Adjusted for better visibility
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )),
      Tween<Offset>(
        begin: const Offset(-1.5, 1.0), // Bottom left
        end: const Offset(-0.8, -1.5), // Adjusted for better visibility
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )),
      Tween<Offset>(
        begin: const Offset(1.5, 1.0), // Bottom right
        end: const Offset(0.5, 0.7), // Adjusted for better visibility
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )),
      Tween<Offset>(
        begin: const Offset(0.0, -2.5), // Center top for yoga image
        end: const Offset(-0.5, 0.5), // Adjusted for better visibility
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )),
    ];

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated images flying in
            ..._buildAnimatedImages(),
            // Main title in the center
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                ),
                const Text(
                  'Skip the Streak',
                  style: TextStyle(
                    fontSize: 50, // Increased text size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainHabitsScreen()));
                    },
                    child: const Text('Get Started!')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedImages() {
    final imagePaths = [
      'lib/assets/images/dummy_books.png',
      'lib/assets/images/dummy_dog.png',
      'lib/assets/images/dummy_joga.png',
      'lib/assets/images/dummy_water.png',
      'lib/assets/images/dummy_joga.png', // Duplicated yoga image
    ];

    // Adjusted sizes with more variation, making the water bottle bigger
    final sizes = [
      200.0,
      200.0,
      200.0,
      200.0,
      200.0
    ]; // Water bottle is now bigger

    return List<Widget>.generate(imagePaths.length, (index) {
      return SlideTransition(
        position: _imageAnimations[index],
        child: SizedBox(
          width: sizes[index],
          height: sizes[index],
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.contain,
          ),
        ),
      );
    });
  }
}
