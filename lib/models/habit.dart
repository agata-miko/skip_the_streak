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
