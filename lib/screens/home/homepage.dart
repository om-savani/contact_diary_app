import 'package:flutter/material.dart';

import '../../routes/all_routes.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        // actions: [
        //   Switch(
        //     value: Globals.theme == ThemeMode.light,
        //     onChanged: Globals.themeMode,
        //   ),
        // ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No Content Found'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addContact);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
