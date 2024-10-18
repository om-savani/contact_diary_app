import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/all_routes.dart';
import '../../home/provider/home_provider.dart';

class HideContactScreen extends StatefulWidget {
  const HideContactScreen({super.key});

  @override
  State<HideContactScreen> createState() => _HideContactScreenState();
}

class _HideContactScreenState extends State<HideContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Hide Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().Details.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible:
                  context.watch<HomeProvider>().Details[index].ishided == true,
              child: ListTile(
                onLongPress: () =>
                    context.read<HomeProvider>().removeDetails(index),
                onTap: () {
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
                title: Text(context.read<HomeProvider>().Details[index].name!),
                subtitle:
                    Text(context.read<HomeProvider>().Details[index].number!),
                trailing: IconButton(
                    onPressed: () async {
                      await launchUrl(
                          "tel:${context.read<HomeProvider>().Details[index].number}"
                              as Uri);
                    },
                    icon: const Icon(Icons.phone)),
              ),
            );
          },
        ),
      ),
    );
  }
}
