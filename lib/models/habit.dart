class Habit {
  final String imagePath;
  final String title;
  final int number;
  DateTime? startDate;
  bool isTapped;

  Habit({
    required this.imagePath,
    required this.title,
    this.number = 0,
    this.startDate,
    this.isTapped = false,
  });
}
