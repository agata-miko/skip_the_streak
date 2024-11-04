import 'package:flutter/foundation.dart';
import '../models/habit.dart';

@immutable
abstract class HiveState {}

class HiveInitial extends HiveState {}

class HiveLoading extends HiveState {}

class HiveLoaded extends HiveState {
  final List<Habit> habits;

  HiveLoaded(this.habits);
}

class HiveStateError extends HiveState {
  final String message;

  HiveStateError(this.message);
}
