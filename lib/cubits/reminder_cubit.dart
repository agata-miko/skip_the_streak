import 'package:flutter_bloc/flutter_bloc.dart';

//TODO pass the users choice to the db to ensure app remembers it between usages

class ReminderState {
  final bool isSwitched;
  const ReminderState({required this.isSwitched});
}
class ReminderCubit extends Cubit<ReminderState> {

  ReminderCubit() : super(const ReminderState(isSwitched: false));

  void toggleTheme(bool isSwitched) {
    emit(ReminderState(isSwitched: !state.isSwitched));
  }
}