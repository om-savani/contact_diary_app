import 'package:contact_diary_app/screens/home/models/contact_models.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List<ContactModel> Details = [];

  void addDetails(ContactModel model) {
    Details.add(model);
    notifyListeners();
  }

  void removeDetails(int index) {
    Details.removeAt(index);
    notifyListeners();
  }
}
