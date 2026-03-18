import 'package:evently_c18/common/theme/app_themes.dart';
import 'package:evently_c18/screens/auth/login_screen.dart';
import 'package:evently_c18/screens/auth/register_screen.dart';
import 'package:evently_c18/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        SplashScreen.routeName: (_) => SplashScreen(),
      },
      theme: AppThemes.lightTheme,

      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
