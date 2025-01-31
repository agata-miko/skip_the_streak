import 'package:flutter_bloc/flutter_bloc.dart';


class StartDateState {
  final bool isDateSet;
  final DateTime? startDate;
  const StartDateState({required this.isDateSet, this.startDate});
}

class StartDateCubit extends Cubit<StartDateState> {

  StartDateCubit() : super(const StartDateState(isDateSet: false));

  void toggleStartDate(bool isDateSet) {
    emit(StartDateState(isDateSet: !state.isDateSet));
  }

  void resetStartDate() {
    emit(const StartDateState(isDateSet: false));
  }

  void setStartDate(DateTime date) {
    emit(StartDateState(isDateSet: true, startDate: date));
  }
}