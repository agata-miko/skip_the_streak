import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 0) // Define a unique typeId
class Habit {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  final int number;

  @HiveField(5)
  DateTime? startDate;

  @HiveField(6)
  bool isTapped;

  @HiveField(7)
  int? milestone;

  Habit ({
    String? id,
    required this.imagePath,
    required this.title,
    this.description,
    this.number = 0,
    this.startDate,
    this.isTapped = false,
    this.milestone,
  }) : id = id ?? const Uuid().v4();
}

extension HabitExtension on Habit {
  Habit copyWith({
    String? id,
    String? imagePath,
    String? title,
    String? description,
    int? number,
    DateTime? startDate,
    bool? isTapped,
    int? milestone,
  }) {
    return Habit(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      description: description ?? this.description,
      number: number ?? this.number,
      startDate: startDate ?? this.startDate,
      isTapped: isTapped ?? this.isTapped,
      milestone: milestone ?? this.milestone,
    );
  }
}
