import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/habit.dart';
import '../models/habit.dart';
import '../widgets/carousel.dart';
import 'settings_screen.dart';
import '../widgets/milestone_carousel.dart';
import '../cubits/hive_cubit.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  bool _isSwitched = false;
  bool _isSwitched_2 = false;
  DateTime? _selectedDate;
  final List<String> imgList = [
    'lib/assets/images/dummy_books.png',
    'lib/assets/images/dummy_dog.png',
    'lib/assets/images/dummy_joga.png',
    'lib/assets/images/dummy_water.png',
    'lib/assets/images/dummy_joga.png',
  ];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, // Scroll to the bottom
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _addHabit() {
    final newHabit = Habit(
      imagePath: 'lib/assets/images/dummy_books.png',
      title: _titleController.text,
      description: _descriptionController.text,
      startDate: _selectedDate,
      // Add other properties as needed
    );

    context
        .read<HiveCubit>()
        .addHabit(newHabit); // Call the addHabit method from HiveCubit
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  onChanged: (value) {
                    (_titleController.text = value);
                  },
                  maxLength: 50,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Title'),
                    helperText: 'The name of your habit, e.g. \'reading\'',
                    suffixIcon: IconButton(
                        onPressed: () {
                          _titleController.clear();
                        },
                        icon: Icon(Icons.highlight_remove_outlined)),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: TextField(
                  onChanged: (value) {
                    (_descriptionController.text = value);
                  },
                  maxLength: 150,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Description'),
                    helperText: 'Additional info, e.g. \'10 pages\' (optional)',
                    suffixIcon: IconButton(
                        onPressed: () {
                          _descriptionController.clear();
                        },
                        icon: Icon(Icons.highlight_remove_outlined)),
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
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          icon: Icon(Icons.info_outline, color: Colors.grey),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Info about Start Date')),
                            );
                          },
                        ),
                      ],
                    ),
                    Switch(
                      value: _isSwitched,
                      onChanged: (value) {
                        setState(() {
                          _isSwitched = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_isSwitched)
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
                          Text(
                            'Select Start Date',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: _selectDate,
                            child: Text(
                              _selectedDate == null
                                  ? 'Pick a date'
                                  : '${_selectedDate!.toLocal()}'.split(' ')[0],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Space between the date picker and milestone
                    ],
                  ),
                ),
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
                          AppLocalizations.of(context)!.milestone,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          icon: Icon(Icons.info_outline, color: Colors.grey),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Info about Milestone')),
                            );
                          },
                        ),
                      ],
                    ),
                    Switch(
                      value: _isSwitched_2,
                      onChanged: (value) {
                        setState(() {
                          _isSwitched_2 = value;
                          if (_isSwitched_2) {
                            _scrollToMilestonePicker(); // Auto-scroll to milestone picker
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_isSwitched_2) MilestoneCarousel(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _addHabit,
                  child: Text('Add habit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
