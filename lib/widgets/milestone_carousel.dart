import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skip_the_streak/cubits/milestone_cubit.dart';

class MilestoneCarousel extends StatefulWidget {
  const MilestoneCarousel({super.key});

  @override
  MilestoneCarouselState createState() => MilestoneCarouselState();
}

class MilestoneCarouselState extends State<MilestoneCarousel> {
  late int? _selectedIndex;
  late FixedExtentScrollController? _scrollController;

  // @override
  //   // void initState() {
  //   //   super.initState();
  //   //   final milestoneCubit = context.read<MilestoneCubit>().state;
  //   //   if (milestoneCubit.isMilestoneSet && milestoneCubit.milestone != null) {
  //   //     _selectedIndex = milestoneCubit.milestone! - 1;
  //   //   } else {
  //   //     _selectedIndex = 0;
  //   //   }
  //   // }

  // Track the selected item index
  // void _onMilestoneSelected(int milestone) {
  //   context.read<MilestoneCubit>().setMilestone(milestone);
  // }
  @override
  void initState() {
    super.initState();
    final milestoneState = context.read<MilestoneCubit>().state;
    _selectedIndex =
        milestoneState.isMilestoneSet && milestoneState.milestone != null
            ? milestoneState.milestone! - 1
            : null;
    _scrollController = _selectedIndex != null
        ? FixedExtentScrollController(initialItem: _selectedIndex!)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MilestoneCubit, MilestoneState>(
        listenWhen: (previous, current) =>
            previous.milestone != current.milestone,
        listener: (context, state) {
          if (state.isMilestoneSet && state.milestone != null) {
            _scrollController!.animateToItem(state.milestone! - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          }
        },
        child: BlocBuilder<MilestoneCubit, MilestoneState>(
          builder: (context, state) {
            _selectedIndex = state.isMilestoneSet && state.milestone != null
                ? state.milestone! - 1
                : 0;

            return SizedBox(
              height: 80, // Adjusted height of the carousel container
              child: Stack(
                children: [
                  ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    itemExtent: 40,
                    // Adjusted height of each item
                    diameterRatio: 2,
                    perspective: 0.01,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedIndex =
                            index; // Update the selected item index
                      });
                      context.read<MilestoneCubit>().setMilestone(index + 1);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index >= 0 && index < 100) {
                          return Center(
                            child: Text(
                              '${(index + 1)}', // Milestone values
                              style: TextStyle(
                                fontSize: _selectedIndex == index ? 24 : 18,
                                // Adjusted font sizes
                                fontWeight: _selectedIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _selectedIndex == index
                                    ? Colors
                                        .blue // Different color for the selected item
                                    : Colors.grey,
                              ),
                            ),
                          );
                        } else {
                          return null; // Stops creating more items after 100 milestones
                        }
                      },
                    ),
                  ),
                  // Top divider line
                  Positioned(
                    top: 50, // Slight space from the selected number
                    left: MediaQuery.of(context).size.width *
                        0.4, // Adjusted left position
                    right: MediaQuery.of(context).size.width *
                        0.4, // Adjusted right position
                    child: Divider(
                      color: Colors.blueAccent.withOpacity(0.6),
                      thickness: 1.5,
                      // Adjusted width for a shorter divider
                      indent: 20, // Space from the left
                      endIndent: 20, // Space from the right
                    ),
                  ),

                  // Bottom divider line
                  Positioned(
                    bottom: 50, // Slight space from the selected number
                    left: MediaQuery.of(context).size.width *
                        0.4, // Adjusted left position
                    right: MediaQuery.of(context).size.width *
                        0.4, // Adjusted right position
                    child: Divider(
                      color: Colors.blueAccent.withOpacity(0.6),
                      thickness: 1.5,
                      // Adjusted width for a shorter divider
                      indent: 20, // Space from the left
                      endIndent: 20, // Space from the right
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
