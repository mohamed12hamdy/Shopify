import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopify/Login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shopify/pages.dart';
import 'package:shopify/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options:
      );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget start() {
    if (FirebaseAuth.instance.currentUser != null) {
      return Pages();
    } else {
      return Login();
    }
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              splash: Center(
                child: Text(
                  "shopify",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 80,
                      color: Color(0xFFF2F2F2)),
                ),
              ),
              nextScreen: start(),
              animationDuration: Duration(milliseconds: 1500),
              splashIconSize: double.infinity,
              splashTransition: SplashTransition.decoratedBoxTransition,
            ),
          );
        },
      );
}
