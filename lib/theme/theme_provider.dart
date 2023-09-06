import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xff001b1d),
    primaryColor: Colors.black,
    primaryColorLight: Color.fromARGB(255, 179, 214, 219),
    primaryColorDark: Color.fromARGB(255, 150, 187, 192),
    splashColor: const Color.fromARGB(89, 0, 0, 0),
    cardColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.orangeAccent, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xfffdfdfd),
    primaryColor: Color(0xff9ebec2),
    primaryColorLight: Color(0xff9ebec2),
    primaryColorDark: Color.fromARGB(255, 150, 187, 192),
    splashColor: Color(0xff9fbffd),
    cardColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Color(0xffF25E3D), opacity: 0.8),
  );
}
