import 'package:evently_c18/common/gen/assets.gen.dart';
import 'package:evently_c18/common/widgets/custom_filled_button.dart';
import 'package:evently_c18/common/widgets/custom_outlined_button.dart';
import 'package:evently_c18/common/widgets/custom_text_field.dart';
import 'package:evently_c18/screens/auth/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String routeName = "/registerScreen";
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Assets.images.appLogo.image(width: 150)),
                SizedBox(height: 50),
                Text(
                  "Create your account", //TODO:localization
                  style: theme.textTheme.displayLarge!.copyWith(
                    color: theme.colorScheme.inversePrimary,
                  ),
                ),
                SizedBox(height: 24),

                CustomTextField(
                  hintText: "Enter your name",
                  prefixIconPath: Assets.icons.user.path,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  hintText: "Enter your Email",
                  prefixIconPath: Assets.icons.sms.path,
                ),

                SizedBox(height: 16),
                CustomTextField(
                  hintText: "Enter your Password",
                  prefixIconPath: Assets.icons.lock.path,
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  hintText: "Confirm your password",
                  prefixIconPath: Assets.icons.lock.path,
                  isPassword: true,
                ),
                SizedBox(height: 50),

                CustomFilledButton(text: "Sign up", onPressed: () {}),
                SizedBox(height: 50),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Don’t have an account ? "),
                        TextSpan(
                          text: "Login",
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(
                              context,
                            ).pushReplacementNamed(LoginScreen.routeName),
                        ),
                      ],
                      style: theme.textTheme.labelSmall!.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Center(
                  child: Text(
                    "OR",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomOutlinedButton(
                  child: Row(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.images.googleIcon.image(height: 24, width: 24),
                      Text(
                        "Sign up with google",
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
