import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/carousel.dart';

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
        body: Column(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                          fontSize: 16, // Adjust text size if needed
                        ),
                      ),
                      SizedBox(width: 5), // Space between text and icon
                      IconButton(
                        icon: Icon(Icons.info_outline, color: Colors.grey),
                        onPressed: () {
                          // Show information when the icon is pressed
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Start Date',
                      style: TextStyle(
                        fontSize: 16, // Adjust text size if needed
                      ),
                    ),
                    SizedBox(width: 5), // Space between text and icon
                    TextButton(
                      onPressed: _selectDate,
                      child: Text(
                        _selectedDate == null
                            ? 'Pick a date'
                            : '${_selectedDate!.toLocal()}'.split(' ')[0],
                        style: TextStyle(
                          fontSize: 16, // Adjust text size if needed
                          color: Colors.blue,
                        ),
                      ),
                    ),
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
                          fontSize: 16, // Adjust text size if needed
                        ),
                      ),
                      SizedBox(width: 5), // Space between text and icon
                      IconButton(
                        icon: Icon(Icons.info_outline, color: Colors.grey),
                        onPressed: () {
                          // Show information when the icon is pressed
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
          ],
        ),
      ),
    );
  }
}
