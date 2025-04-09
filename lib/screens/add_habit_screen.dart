import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubits/carousel_cubit.dart';
import '../cubits/milestone_cubit.dart';
import '../cubits/start_date_cubit.dart';
import '../models/habit.dart';
import '../widgets/carousel.dart';
import '../widgets/milestone_carousel.dart';
import '../cubits/hive_cubit.dart';
import '../constants/image_assets.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();



  @override
  void initState() {
    super.initState();
    context.read<CarouselCubit>().selectImage(null);
    context.read<MilestoneCubit>().resetMilestone();
    context.read<StartDateCubit>().resetStartDate();
  }

  void _scrollToMilestonePicker() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _addHabit() {
    final selectedImage = context.read<CarouselCubit>().state;
    final startDateState = context.read<StartDateCubit>().state;
    final milestone = context.read<MilestoneCubit>().state.milestone;

    final newHabit = Habit(
      imagePath: selectedImage ?? 'lib/assets/images/tick_lines.png',
      title: _titleController.text,
      description: _descriptionController.text,
      startDate: startDateState.isDateSet ? startDateState.startDate : null,
      milestone: milestone!= null ? milestone : null,
    );

    context.read<HiveCubit>().addHabit(newHabit);
    Navigator.pop(context);
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
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CarouselWidget(imgList: imgList),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: TextField(
                  controller: _titleController,
                  maxLength: 25,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Title'),
                    helperText: 'The name of your habit, e.g. \'reading\'',
                    suffixIcon: IconButton(
                      onPressed: _titleController.clear,
                      icon: const Icon(Icons.highlight_remove_outlined),
                    ),
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
                  maxLength: 150,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Description'),
                    helperText: 'Additional info, e.g. \'10 pages\' (optional)',
                    suffixIcon: IconButton(
                      onPressed: _descriptionController.clear,
                      icon: const Icon(Icons.highlight_remove_outlined),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              BlocBuilder<StartDateCubit, StartDateState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.startDate,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Switch(
                              value: state.isDateSet,
                              onChanged: (value) {
                                context
                                    .read<StartDateCubit>()
                                    .toggleStartDate(value);
                              },
                            ),
                          ],
                        ),
                        if (state.isDateSet)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Selected Date:',
                                  style: TextStyle(fontSize: 16)),
                              TextButton(
                                onPressed: () async {
                                  DateTime now = DateTime.now();
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: state.startDate ?? now,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );

                                  if (picked != null) {
                                    context
                                        .read<StartDateCubit>()
                                        .setStartDate(picked);
                                  }
                                },
                                child: Text(
                                  state.startDate == null
                                      ? 'Pick a date'
                                      : '${state.startDate!.toLocal()}'
                                          .split(' ')[0],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
              BlocBuilder<MilestoneCubit, MilestoneState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Column(
                      children: [
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
                                  icon: const Icon(Icons.info_outline,
                                      color: Colors.grey),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Info about Milestone')),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Switch(
                                value: state.isMilestoneSet,
                                onChanged: (value) {
                                  context
                                      .read<MilestoneCubit>()
                                      .toggleMilestone(value);
                                }),
                          ],
                        ),
                        if (state.isMilestoneSet) const MilestoneCarousel(),
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
                  onPressed: _addHabit,
                  child: const Text('Add habit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
