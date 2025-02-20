import 'package:flutter_bloc/flutter_bloc.dart';

class MilestoneState {
  final int? milestone;
  final bool isMilestoneSet;

  const MilestoneState({
    this.milestone,
    this.isMilestoneSet = false,
  });

  MilestoneState copyWith({
    int? milestone,
    bool? isMilestoneSet,
  }) {
    return MilestoneState(
      milestone: milestone ?? this.milestone,
      isMilestoneSet: isMilestoneSet ?? this.isMilestoneSet,
    );
  }
}

class MilestoneCubit extends Cubit<MilestoneState> {
  MilestoneCubit() : super(const MilestoneState(isMilestoneSet: false));

  // Toggle the milestone state
  void toggleMilestone() {
    if (state.isMilestoneSet) {
      // If the milestone is already set, reset it (i.e., set milestone to null)
      emit(const MilestoneState(isMilestoneSet: false, milestone: null));
    } else {
      // If it's not set, keep the current milestone value (if any), or set to a default one
      // Here, I'm assuming a default value of 1 as an example.
      emit(MilestoneState(
        isMilestoneSet: true,
        milestone: state.milestone ?? 1, // Use the current milestone or a default
      ));
    }
  }

  // Reset the milestone to its initial state
  void resetMilestone() {
    emit(const MilestoneState(isMilestoneSet: false, milestone: null));
  }

  // Set a specific milestone
  void setMilestone(int milestone) {
    emit(MilestoneState(isMilestoneSet: true, milestone: milestone));
  }
}
