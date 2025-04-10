import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubits/dark_theme_cubit.dart';
import '../cubits/language_cubit.dart';
import 'about_screen.dart';
import 'reminder_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
    return Scaffold(
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppLocalizations.of(context)!.settings,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: context.read<ThemeCubit>().state.isDarkMode,
              onChanged: (bool value) {
                context.read<ThemeCubit>().toggleTheme(value);
              },
            ),
            onTap: () {
              // Handle light/dark mode toggle
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<Locale>(
              value: context.read<LanguageCubit>().state,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  context.read<LanguageCubit>().changeLanguage(newValue);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: Locale('en'), // English
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('pl'), // Spanish
                  child: Text('Polski'),
                ),
                // Add more languages here
              ],
            ),
          ),
          ListTile(
            title: const Text('Reminders'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // Allows for full-height modals
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top:
                          Radius.circular(20)), // Rounded corners for the modal
                ),
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const FractionallySizedBox(
                      heightFactor: 0.9, // Use 90% of the screen height
                      child: ReminderScreen(),
                    ),
                  );
                },
              );
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () async {
              Navigator.pop(context);
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                // makes it full height
                backgroundColor: Colors.transparent,
                // remove default round corners
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      child: AboutScreen(),
                    ),
                  );
                },
              );
              // Close the drawer
            },
          ),
          // ListTile(
          //   title: const Text('Profile'),
          //   onTap: () {
          //     // Navigate to Profile Screen
          //     Navigator.pop(context); // Close the drawer
          //     // Navigate to Profile screen here
          //   },
          // ),
          // ListTile(
          //   title: const Text('Privacy Policy'),
          //   onTap: () {
          //     // Show Privacy Policy (implement it accordingly)
          //     Navigator.pop(context); // Close the drawer
          //   },
          // ),
        ],
      ),
    );
  }
}
