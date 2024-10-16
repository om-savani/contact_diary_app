import 'dart:io';
import 'package:contact_diary_app/screens/home/models/contact_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../home/provider/home_provider.dart';

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              Form(
                key: formKey,
                child: Stepper(
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
                      content: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Name', border: OutlineInputBorder()),
                      ),
                    ),
                    Step(
                      title: const Text('Number'),
                      content: TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Number';
                          } else if (value.length < 10) {
                            return 'Number Must Be 10 Digit';
                          }
                          return null;
                        },
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            hintText: 'Number', border: OutlineInputBorder()),
                      ),
                    ),
                    Step(
                      title: const Text('Email'),
                      content: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Email', border: OutlineInputBorder()),
                      ),
                    ),
                    Step(
                      title: const Text('Save'),
                      content: ElevatedButton(
                        onPressed: () {
                          bool isvalid = formKey.currentState!.validate();
                          if (isvalid) {
                            String name = nameController.text;
                            String number = numberController.text;
                            String email = emailController.text;
                            ContactModel details = ContactModel(
                              name: name,
                              number: number,
                              email: email,
                              image: path,
                            );
                            context.read<HomeProvider>().addDetails(details);
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please Fill All Fields'),
                              ),
                            );
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
