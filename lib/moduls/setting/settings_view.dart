import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsView> {
  bool _isDarkMode = false;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<Locale>(
              value: _locale,
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text('العربية'),
                ),
              ],
              onChanged: (locale) {
                setState(() {
                  _locale = locale!;
                });
              },
              hint: const Text('Select Language'),
            ),
          ],
        ),
      ),
    );
  }
}
