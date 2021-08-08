import 'package:flutter/material.dart';

class SettingsInteractor extends ChangeNotifier {
  bool isDark = false;

  bool get getIsDark => isDark;

  set changeTheme(bool val) {
    isDark = val;
    notifyListeners();
  }
}

SettingsInteractor settingsInteractor = SettingsInteractor();
