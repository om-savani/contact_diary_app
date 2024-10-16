import 'dart:io';

import 'package:contact_diary_app/main.dart';
import 'package:contact_diary_app/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().Details.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () =>
                  context.read<HomeProvider>().removeDetails(index),
              leading: CircleAvatar(
                foregroundImage: FileImage(
                  File(
                      context.watch<HomeProvider>().Details[index].image ?? ''),
                ),
                child: Center(
                  child: Text(
                    context
                        .watch<HomeProvider>()
                        .Details[index]
                        .name![0]
                        .toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              title: Text(
                  context.watch<HomeProvider>().Details[index].name.toString()),
              subtitle: Text(context
                  .watch<HomeProvider>()
                  .Details[index]
                  .number
                  .toString()),
            );
          },
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
