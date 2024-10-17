import 'package:contact_diary_app/screens/home/models/contact_models.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List<ContactModel> Details = [];
  int selectedIndex = 0;
  void addDetails(ContactModel model) {
    Details.add(model);
    notifyListeners();
  }

  void removeDetails(int index) {
    Details.removeAt(index);
    notifyListeners();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void UpdateDetails(ContactModel model) {
    Details[selectedIndex] = model;
    notifyListeners();
  }
}
