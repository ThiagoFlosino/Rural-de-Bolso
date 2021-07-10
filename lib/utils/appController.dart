import 'package:flutter/widgets.dart';

class appController extends ChangeNotifier {
  static appController instance = new appController();

  bool isDarkMode = false;
  bool isLogged = false;

  changeTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  setIsLogged(bool value) {
    isLogged = value;
    notifyListeners();
  }
}
