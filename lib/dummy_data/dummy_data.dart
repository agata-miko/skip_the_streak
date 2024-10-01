import 'package:skip_the_streak/models/habit.dart';

final List<String> imgList = [
  'lib/assets/images/dummy_books.png',
  'lib/assets/images/dummy_dog.png',
  'lib/assets/images/dummy_joga.png',
  'lib/assets/images/dummy_water.png',
  'lib/assets/images/dummy_joga.png',
];

List<Habit> cards = [
  Habit(
      imagePath: imgList[0],
      title: 'Jogging',
      description:
      '1 - 2 km',
      number: 17),
  Habit(
      imagePath: imgList[1],
      title: 'Hydration',
      description: '2l per day.',
  ),
  Habit(
      title: 'Reading',
      imagePath: imgList[3],
      number: 100),
  Habit(
      title: 'Card 4',
      description: 'This is the fourth card.',
      imagePath: imgList[4],
      number: 20),
  Habit(
      title: 'Card 1',
      description:
      'This is the first card. It has a lot of text to demonstrate overflow handling.',
      imagePath: imgList[3],
      number: 17),
  Habit(
      title: 'Card 2',
      description: 'This is the second card.',
      imagePath: imgList[2],
      number: 2),
  Habit(
      title: 'Card 3',
      description: 'This is the third card.',
      imagePath: imgList[1],
      number: 100),
];