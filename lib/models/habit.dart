import 'package:uuid/uuid.dart';

class Habit {
  final String id;
  final String imagePath;
  final String title;
  String? description;
  final int number;
  DateTime? startDate;
  bool isTapped;

  Habit({
    String? id,
    required this.imagePath,
    required this.title,
    this.description,
    this.number = 0,
    this.startDate,
    this.isTapped = false,
  }) : id = id ?? const Uuid().v4();
}
