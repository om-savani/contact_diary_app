import 'dart:io';

import 'package:contact_diary_app/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
        actions: [
          IconButton(
              onPressed: () async {
                LocalAuthentication auth = LocalAuthentication();

                bool isAuthenticated = await auth.authenticate(
                  localizedReason: "Open to access hidden contacts !!",
                );

                if (isAuthenticated) {
                  Navigator.of(context).pushNamed(AppRoutes.hidecontact);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Authentication Failed"),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.lock))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().Details.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible:
                  context.watch<HomeProvider>().Details[index].ishided == false,
              child: ListTile(
                onLongPress: () =>
                    context.read<HomeProvider>().removeDetails(index),
                onTap: () {
                  context.read<HomeProvider>().changeIndex(index);
                  Navigator.pushNamed(context, AppRoutes.details,
                      arguments: context.read<HomeProvider>().Details[index]);
                },
                leading: CircleAvatar(
                  foregroundImage: FileImage(
                    File(context.watch<HomeProvider>().Details[index].image ??
                        ''),
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
                title: Text(context
                    .watch<HomeProvider>()
                    .Details[index]
                    .name
                    .toString()),
                subtitle: Text(context
                    .watch<HomeProvider>()
                    .Details[index]
                    .number
                    .toString()),
                trailing: IconButton(
                  onPressed: () async {
                    Uri contactNo = Uri.parse(
                        'tel : ${context.read<HomeProvider>().Details[index].number}');
                    await launchUrl(contactNo);
                  },
                  icon: const Icon(Icons.phone),
                ),
              ),
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
