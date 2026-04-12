import 'package:evently_c18/common/theme/app_themes.dart';
import 'package:evently_c18/firebase_options.dart';
import 'package:evently_c18/screens/auth/login_screen.dart';
import 'package:evently_c18/screens/auth/register_screen.dart';
import 'package:evently_c18/screens/auth/splash_screen.dart';
import 'package:evently_c18/screens/home/home_screen.dart';
import 'package:evently_c18/provider/theme_provider.dart';
import 'package:evently_c18/screens/events/add_new_event/add_new_event_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            LoginScreen.routeName: (_) => LoginScreen(),
            RegisterScreen.routeName: (_) => RegisterScreen(),
            SplashScreen.routeName: (_) => SplashScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            AddNewEventScreen.routeName: (_) => AddNewEventScreen(),
          },
          theme: AppThemes.lightTheme,

          darkTheme: AppThemes.darkTheme,
          themeMode: value.themeMode,
        ),
      ),
    );
  }
}
