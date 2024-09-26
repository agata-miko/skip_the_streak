import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/carousel.dart';
import '../widgets/milestone_carousel.dart';

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
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400?text=Second',
    'https://via.placeholder.com/600x400?text=Third',
  ];

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'New habit',
                  style: TextStyle(
                      fontSize: 28,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              CarouselWidget(imgList: imgList),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Title'),
                      helperText: 'The name of your habit, e.g. \'reading\'',
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.highlight_remove_outlined))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Description'),
                      helperText: 'Additional info, e.g. \'10 pages\' (optional)',
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.highlight_remove_outlined))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.startDate,
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
              // Row for Select Start Date only shows if switch is on
              if (_isSwitched)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      // Add space between date picker and milestone only when the date picker is visible
                      SizedBox(height: 10), // Space between the date picker and milestone
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.milestone,
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Show MilestoneCarousel only if the switch is on
              if (_isSwitched_2)
                MilestoneCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}
