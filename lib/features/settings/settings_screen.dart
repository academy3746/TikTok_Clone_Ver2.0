import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1980),
              lastDate: DateTime(2030),
            ),
            title: const Text("When is your birthday?"),
          ),
          const AboutListTile(
            applicationVersion: "1.0",
            applicationLegalese: "All rights reserved by Jonghyun Lee.",
          ),
        ],
      ),
    );
  }
}
