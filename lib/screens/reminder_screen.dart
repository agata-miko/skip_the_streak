import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_screen.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool _isSwitched = false;
  TimeOfDay? _selectedTime;

  // Function to pick a time for the reminder
  Future<void> _selectTime() async {
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked; //TODO refactor to BloC
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double horizontalPadding = screenSize.width * 0.04;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.settings), // Settings icon
                  onPressed: () {
                    // Open the drawer when settings icon is tapped
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ],
        ),
        drawer: SettingsScreen(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenSize.height * 0.025),
                Text(
                  'Reminders',
                  style: TextStyle(
                    fontSize: 28,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.015),
                Text(
                  'At Skip the Streak, we believe that a no-pressure environment is the best way to foster true progress.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenSize.height * 0.015),
                Text(
                  'However, if you feel like you could use a gentle nudge once a day, you can set it up right here.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenSize.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Reminder', // Changed from 'Start Date' to 'Reminder'
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          icon: Icon(Icons.info_outline, color: Colors.grey),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Info about Reminder')),
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
                // Time picker display
                if (_isSwitched)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              onPressed: _selectTime,
                              child: Text(
                                _selectedTime == null
                                    ? 'Pick a time'
                                    : '${_selectedTime!.format(context)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
