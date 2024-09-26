import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'reminder_screen.dart'; // Ensure this path is correct

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // Initial value for dark mode
  String _selectedLanguage = 'en'; // Initial language

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
      // Apply theme changes here if using theme mode
    });
  }

  void _changeLanguage(String? languageCode) {
    setState(() {
      _selectedLanguage = languageCode!;
      // Implement language change logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.width * 0.05; // Dynamic font size based on width

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'), // Localized title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark Mode ListTile
            ListTile(
              title: Text('Dark Mode', style: TextStyle(fontSize: fontSize)),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
              ),
            ),

            // Consistent Spacing
            const SizedBox(height: 16), // Space between rows

            // Language Selection ListTile
            ListTile(
              title: Text('Language', style: TextStyle(fontSize: fontSize)),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: _changeLanguage,
                items: <String>['en', 'pl'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'en' ? 'English' : 'Polski', style: TextStyle(fontSize: fontSize)),
                  );
                }).toList(),
              ),
            ),

            // Consistent Spacing
            const SizedBox(height: 16), // Space between rows

            // Reminders Navigation
            ListTile(
              title: Text('Reminders', style: TextStyle(fontSize: fontSize)),
              onTap: () {
                // Navigate to ReminderScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReminderScreen()),
                );
              },
            ),

            // Consistent Spacing
            const SizedBox(height: 16), // Space between rows

            // Profile Navigation
            ListTile(
              title: Text('Profile', style: TextStyle(fontSize: fontSize)),
              onTap: () {
                // Navigate to Profile Screen (you need to create it)
              },
            ),

            // Consistent Spacing
            const SizedBox(height: 16), // Space between rows

            // Privacy Policy Navigation
            ListTile(
              title: Text('Privacy Policy', style: TextStyle(fontSize: fontSize)),
              onTap: () {
                // Show Privacy Policy (could be a WebView or external link)
              },
            ),
          ],
        ),
      ),
    );
  }
}
