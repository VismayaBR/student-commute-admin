import 'package:flutter/material.dart';

class AdminController with ChangeNotifier {
  bool isObsecure = true;

  changeObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }
}
