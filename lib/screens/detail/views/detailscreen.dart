import 'dart:io';

import 'package:contact_diary_app/screens/home/models/contact_models.dart';
import 'package:contact_diary_app/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';

class Detailscreen extends StatefulWidget {
  const Detailscreen({super.key});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;
    nameController.text = model.name!;
    emailController.text = model.email!;
    numberController.text = model.number!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Edit Contact"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      TextField(
                        controller: numberController,
                        decoration: const InputDecoration(labelText: "Number"),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        ContactModel cmodel = ContactModel(
                          name: nameController.text,
                          number: numberController.text,
                          email: emailController.text,
                          image: model.image,
                        );
                        context.read<HomeProvider>().UpdateDetails(cmodel);
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                foregroundImage: FileImage(
                  File(model.image ?? ''),
                ),
                child: Center(
                  child: Text(
                    model.name!.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              50.h,
              ListTile(
                leading: const Text(
                  "Name: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.name!),
              ),
              10.h,
              ListTile(
                leading: const Text(
                  "Email: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.email!),
              ),
              10.h,
              ListTile(
                leading: const Text(
                  "Number: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.number!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
