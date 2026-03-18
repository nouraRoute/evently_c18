import 'package:evently_c18/common/gen/assets.gen.dart';
import 'package:evently_c18/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AnimatedContainer(
                duration: Duration(seconds: 5),

                curve: Curves.fastOutSlowIn,

                width: animate ? 300 : 0,
                onEnd: () {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginScreen.routeName,
                  );
                },
                child: Assets.images.appLogo.image(),
              ),

              Spacer(),
              Assets.images.routeLogo.image(),
              SizedBox(height: 8),
              Text(
                "Supervised by Mohamed Nabil",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ), //TODO:localization
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
