import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/globals.dart';

class addContactPage extends StatefulWidget {
  const addContactPage({super.key});

  @override
  State<addContactPage> createState() => _addContactPageState();
}

class _addContactPageState extends State<addContactPage> {
  int stepIndex = 0;
  String? path;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.back)),
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stepper(
                onStepContinue: () {
                  setState(() {
                    if (stepIndex < 4) {
                      stepIndex++;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (stepIndex > 0) {
                      stepIndex--;
                    }
                  });
                },
                currentStep: stepIndex,
                steps: [
                  Step(
                    title: const Text('Photo'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        path == null
                            ? const CircleAvatar(
                                radius: 60,
                                child: Icon(Icons.person),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(path!)),
                              ),
                        ElevatedButton(
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            path = image!.path;
                            setState(() {});
                          },
                          child: const Text('Add Photo'),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Name'),
                    content: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: 'Name', border: OutlineInputBorder()),
                    ),
                  ),
                  Step(
                    title: const Text('Number'),
                    content: TextField(
                      controller: numberController,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                          hintText: 'Number', border: OutlineInputBorder()),
                    ),
                  ),
                  Step(
                    title: const Text('Email'),
                    content: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email', border: OutlineInputBorder()),
                    ),
                  ),
                  Step(
                    title: const Text('Save'),
                    content: ElevatedButton(
                      onPressed: () {
                        Globals.name = nameController.text;
                        Globals.number = numberController.text;
                        Globals.email = emailController.text;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "${Globals.name}, ${Globals.number}, ${Globals.email}")),
                        );
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
