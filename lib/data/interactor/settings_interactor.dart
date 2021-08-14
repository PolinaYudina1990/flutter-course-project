import 'package:flutter/material.dart';

class SettingsInteractor extends ChangeNotifier {
  bool isDark = false;

  bool get getIsDark => isDark;

  changeTheme(bool val) {
    isDark = val;
    notifyListeners();
  }
}

SettingsInteractor settingsInteractor = SettingsInteractor();
