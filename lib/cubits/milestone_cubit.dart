import 'package:flutter_bloc/flutter_bloc.dart';

class MilestoneState {
  final bool isMilestoneSet;
  final int? milestone;
  const MilestoneState({required this.isMilestoneSet, this.milestone});
}

class MilestoneCubit extends Cubit<MilestoneState> {
  MilestoneCubit() : super(const MilestoneState(isMilestoneSet: false));

  void toggleMilestone(bool isMilestoneSet) {
    emit(MilestoneState(isMilestoneSet: !state.isMilestoneSet));
  }

  void resetMilestone() {
    emit(const MilestoneState(isMilestoneSet: false));
  }

  void setMilestone(int milestone) {
    emit(MilestoneState(isMilestoneSet: true, milestone: milestone));
  }
}