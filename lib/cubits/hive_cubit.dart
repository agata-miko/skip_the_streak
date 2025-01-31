import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart';
import 'package:skip_the_streak/cubits/hive_state.dart';

class HiveCubit extends Cubit<HiveState> {
  final Box<Habit> habitBox;

  HiveCubit(this.habitBox) : super(HiveInitial());

  // Load all habits from Hive
  void loadHabits() {
    emit(HiveLoading());
    try {
      final habits = habitBox.values.toList();
      emit(HiveLoaded(habits));
    } catch (e) {
      emit(HiveStateError("Failed to load habits: $e"));
    }
  }

  // Add a new habit
  Future<void> addHabit(Habit habit) async {
    await habitBox.add(habit);
    loadHabits(); // Reload habits after adding
  }

  // Delete a habit by index
  Future<void> deleteHabit(String habitId) async {
    try {
      final keyToDelete = habitBox.keys.firstWhere(
        (key) => habitBox.get(key)!.id == habitId,
        orElse: () => null,
      );

      if (keyToDelete != null) {
        await habitBox.delete(keyToDelete);
        loadHabits();
      }
    } catch (e) {
      emit(HiveStateError("Failed to delete habit: $e"));
    }
  }

  Future<void> updateHabit(String habitId, updatedHabit) async {
    try {
      final keyToUpdate = habitBox.keys.firstWhere(
            (key) => habitBox.get(key)!.id == habitId,
        orElse: () => null,
      );

      if (keyToUpdate != null) {
        await habitBox.put(keyToUpdate, updatedHabit);
        loadHabits();
      }
    } catch (e) {
      emit(HiveStateError("Failed to delete habit: $e"));
    }
  }

  Future<void> incrementHabitNumber(String habitId) async {
    try {
      final keyToUpdate = habitBox.keys.firstWhere(
          (key) => habitBox.get(key)!.id == habitId,
        orElse: () => null,
      );

      if (keyToUpdate != null) {
        final updatedHabit = habitBox.get(keyToUpdate)!.copyWith(
    number: habitBox.get(keyToUpdate)!.number + 1,
    );
        await habitBox.put(keyToUpdate, updatedHabit);
        loadHabits();
      }
    } catch (e) {
      emit(HiveStateError("Failed to increment habit number: $e"));
    }
  }

// Add a method to check and add a dummy habit if no habits exist
  void initializeWithDummyHabit() async {
    emit(HiveLoading());
    try {
      if (habitBox.isEmpty) {
        final dummyHabit = Habit(
          title: 'Example Habit',
          description: 'This is a placeholder habit. Tap to edit or remove.',
          number: 0,
          imagePath: 'lib/assets/images/tick_lines.png',
        );
        await habitBox.add(dummyHabit);
      }
      loadHabits();
    } catch (e) {
      emit(HiveStateError("Failed to initialize with dummy habit: $e"));
    }
  }

  Future<void> editStartDate(String habitId, DateTime startDate) async {
    try {
      final keyToUpdate = habitBox.keys.firstWhere(
            (key) => habitBox.get(key)!.id == habitId,
        orElse: () => null,
      );

      if (keyToUpdate != null) {
        final updatedHabit = habitBox.get(keyToUpdate)!.copyWith(startDate: startDate);
        await habitBox.put(keyToUpdate, updatedHabit);
        loadHabits();
      }
    } catch (e) {
      emit(HiveStateError("Failed to save start date: $e"));
    }
  }

  Future<void> editMilestone(String habitId, int milestone) async {
    try {
      final keyToUpdate = habitBox.keys.firstWhere(
            (key) => habitBox.get(key)!.id == habitId,
        orElse: () => null,
      );

      if (keyToUpdate != null) {
        final updatedHabit = habitBox.get(keyToUpdate)!.copyWith(milestone: milestone);
        await habitBox.put(keyToUpdate, updatedHabit);
        loadHabits();
      }
    } catch (e) {
      emit(HiveStateError("Failed to save start date: $e"));
    }
  }

}
