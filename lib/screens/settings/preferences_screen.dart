import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool notifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preferences")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SwitchListTile(
              value: notifications,
              title: const Text("Notifications"),
              onChanged: (v) => setState(() => notifications = v),
            ),
            SwitchListTile(
              value: darkMode,
              title: const Text("Dark Mode"),
              onChanged: (v) => setState(() => darkMode = v),
            )
          ],
        ),
      ),
    );
  }
}
