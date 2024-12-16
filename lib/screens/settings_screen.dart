import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubits/dark_theme_cubit.dart';
import '../cubits/language_cubit.dart';
import 'about_screen.dart';
import 'add_habit_screen.dart';
import 'reminder_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(AppLocalizations.of(context)!.settings,
                style: TextStyle(
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
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ReminderScreen()));
              // Close the drawer
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () async {
              Navigator.pop(context);
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
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
