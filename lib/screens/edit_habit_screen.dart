import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubits/carousel_cubit.dart';
import '../cubits/milestone_cubit.dart';
import '../models/habit.dart';
import '../widgets/carousel.dart';
import '../widgets/milestone_carousel.dart';
import '../cubits/hive_cubit.dart';
import '../constants/image_assets.dart';

class EditHabitScreen extends StatefulWidget {
  final Habit habit;

  const EditHabitScreen({super.key, required this.habit});

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;
  int? _selectedMilestone;

  late bool _isDateSwitched;
  late bool _isMilestoneSwitched;

  @override
  void initState() {
    super.initState();
    final milestoneCubit = context.read<MilestoneCubit>();
    // Set the initial values from the passed habit
    _titleController.text = widget.habit.title;
    _descriptionController.text = widget.habit.description ?? '';
    _selectedDate = widget.habit.startDate;
    _isDateSwitched = widget.habit.startDate != null;
    _selectedMilestone = widget.habit.milestone;
    milestoneCubit.setMilestone(_selectedMilestone ?? 0);
    _isMilestoneSwitched = widget.habit.milestone != null;
    context.read<CarouselCubit>().selectImage(widget.habit.imagePath);
  }

  // Function to save the edited habit
  Future<void> _editHabit() async {
    final milestoneState = context.read<MilestoneCubit>().state;


    final updatedHabit = Habit(
      id: widget.habit.id,
      title: _titleController.text,
      description: _descriptionController.text,
      startDate: _isDateSwitched ? _selectedDate : null,
      isTapped: widget.habit.isTapped,
      imagePath: context.read<CarouselCubit>().state ?? widget.habit.imagePath,
      number: widget.habit.number,
      milestone: _isMilestoneSwitched ? milestoneState.milestone : null,
    );
    print("saved_milestone: ${updatedHabit.milestone}");
    print("_isMilestoneSwitched: $_isMilestoneSwitched");
    print("_selectedMilestone: $_selectedMilestone");
    print("Updated habit: ${updatedHabit.startDate}");

    context.read<HiveCubit>().updateHabit(widget.habit.id, updatedHabit);

    Navigator.pop(context);
  }

  // Date picker function
  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to scroll to the milestone picker
  void _scrollToMilestonePicker() {
    // Delay to allow the UI to update
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, // Scroll to the bottom
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.close), // Settings icon
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController, // Attach the scroll controller
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width * 0.04,
              //       vertical: MediaQuery.of(context).size.height * 0.02),
              //   child: Text(
              //     'New habit',
              //     style: TextStyle(
              //       fontSize: 24,
              //       // Slightly smaller for better balance
              //       color: Theme.of(context).colorScheme.primary,
              //       fontWeight: FontWeight.bold,
              //       // Reduce to 'bold' for cleaner look
              //       letterSpacing: 0.8,
              //       // Subtle letter spacing for refinement
              //       height: 1.4, // Adjust line height for better spacing
              //     ),
              //   ),
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CarouselWidget(imgList: imgList),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    (_titleController.text = value);
                  },
                  maxLength: 25,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Title'),
                    helperText: 'The name of your habit, e.g. \'reading\'',
                    suffixIcon: IconButton(
                        onPressed: () {
                          _titleController.clear();
                        },
                        icon: const Icon(Icons.highlight_remove_outlined)),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: TextField(
                  controller: _descriptionController,
                  onChanged: (value) {
                    (_descriptionController.text = value);
                  },
                  maxLength: 150,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Description'),
                    helperText: 'Additional info, e.g. \'10 pages\' (optional)',
                    suffixIcon: IconButton(
                        onPressed: () {
                          _descriptionController.clear();
                        },
                        icon: const Icon(Icons.highlight_remove_outlined)),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.startDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          icon: const Icon(Icons.info_outline,
                              color: Colors.grey),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Info about Start Date')),
                            );
                          },
                        ),
                      ],
                    ),
                    Switch(
                      value: _isDateSwitched,
                      onChanged: (value) {
                        setState(() {
                          _isDateSwitched = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_isDateSwitched)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Start Date',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 5),
                          TextButton(
                            onPressed: _selectDate,
                            child: Text(
                              _selectedDate == null
                                  ? 'Pick a date'
                                  : '${_selectedDate!.toLocal()}'.split(' ')[0],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Space between the date picker and milestone
                    ],
                  ),
                ),
              BlocBuilder<MilestoneCubit, MilestoneState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Column(
                      children: [
                        // Row with Switch and IconButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.milestone,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 5),
                                IconButton(
                                  icon: const Icon(Icons.info_outline, color: Colors.grey),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Info about Milestone')),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Switch(
                              value: _isMilestoneSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isMilestoneSwitched = value;
                                });
                              },
                            ),
                          ],
                        ),
                        // Conditionally render the MilestoneCarousel widget
                        if (_isMilestoneSwitched == true)
                          MilestoneCarousel(habit: widget.habit),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _editHabit,
                  child: Text(AppLocalizations.of(context)!.edit_habit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
