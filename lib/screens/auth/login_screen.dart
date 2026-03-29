import 'package:evently_c18/common/gen/assets.gen.dart';
import 'package:evently_c18/common/widgets/custom_filled_button.dart';
import 'package:evently_c18/common/widgets/custom_outlined_button.dart';
import 'package:evently_c18/common/widgets/custom_text_field.dart';
import 'package:evently_c18/screens/auth/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = "/loginScreen";
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
                  "Login to your account", //TODO:localization
                  style: theme.textTheme.displayLarge!.copyWith(
                    color: theme.colorScheme.inversePrimary,
                  ),
                ),
                SizedBox(height: 24),

                CustomTextField(
                  hintText: "Enter your Email",
                  prefixIconPath: Assets.icons.sms.path,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  hintText: "Enter your PAssword",
                  prefixIconPath: Assets.icons.lock.path,
                  isPassword: true,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password? ",
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),

                CustomFilledButton(text: "Login", onPressed: () {}),
                SizedBox(height: 50),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Don’t have an account ? "),
                        TextSpan(
                          text: "Signup",
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(
                              context,
                            ).pushReplacementNamed(RegisterScreen.routeName),
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
                        "Login with google",
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
