import 'package:contact_diary_app/screens/add_contact/add_contact_page.dart';
import 'package:contact_diary_app/screens/detail/views/detailscreen.dart';
import 'package:contact_diary_app/screens/hide/views/hide_contact_screen.dart';
import 'package:contact_diary_app/screens/home/homepage.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static String addContact = "addContactPage";
  static String details = "detailScreen";
  static String hidecontact = "hidecontact";

  static Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const Homepage(),
    "addContactPage": (context) => const addContactPage(),
    "detailScreen": (context) => const Detailscreen(),
    "hidecontact": (context) => const HideContactScreen(),
  };
}
