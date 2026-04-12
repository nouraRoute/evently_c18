import 'package:evently_c18/common/gen/assets.gen.dart';
import 'package:evently_c18/common/theme/app_colors.dart';
import 'package:evently_c18/common/utils/validation_utils.dart';
import 'package:evently_c18/common/widgets/custom_filled_button.dart';
import 'package:evently_c18/common/widgets/custom_outlined_button.dart';
import 'package:evently_c18/common/widgets/custom_text_field.dart';
import 'package:evently_c18/network/auth_service.dart';
import 'package:evently_c18/screens/auth/register_screen.dart';
import 'package:evently_c18/screens/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: ListView(
                children: [
                  Center(child: Assets.images.appLogo.image(width: 150)),
                  SizedBox(height: 50),
                  Text(
                    "Login to your account",
                    style: theme.textTheme.displayLarge!.copyWith(
                      color: theme.colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(height: 24),

                  CustomTextField(
                    hintText: "Enter your Email",
                    prefixIconPath: Assets.icons.sms.path,
                    controller: email,
                    validator: (value) {
                      if (ValidationUtils.validateEmptyText(value) == false) {
                        return "empty email!!";
                      } else if (ValidationUtils.validateEmail(value!) == false) {
                        return "invalid email";
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Enter your PAssword",
                    prefixIconPath: Assets.icons.lock.path,
                    isPassword: true,
                    maxLines: 1,
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Empty password!!";
                      }
                    },
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

                  CustomFilledButton(
                    isLoading: isLoading,
                    text: "Login",
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        String? errorMEssage = await AuthService.login(email.text, password.text);
                        setState(() {
                          isLoading = false;
                        });
                        if (errorMEssage != null) {
                          //toast
                          Fluttertoast.showToast(
                            msg: errorMEssage,
                            backgroundColor: AppColors.red,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        } else {
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                          }
                        }
                      }
                    },
                  ),
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
                        style: theme.textTheme.labelSmall!.copyWith(color: theme.hintColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: Text(
                      "OR",
                      style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.primary),
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
      ),
    );
  }
}
