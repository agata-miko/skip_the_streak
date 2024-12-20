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
  Future<void> deleteHabit(int index) async {
    await habitBox.deleteAt(index);
    loadHabits(); // Reload habits after deleting
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
          imagePath: 'lib/assets/images/dummy_dog.png',
        );
        await habitBox.add(dummyHabit);
      }
      loadHabits();
    } catch (e) {
      emit(HiveStateError("Failed to initialize with dummy habit: $e"));
    }
  }

}
