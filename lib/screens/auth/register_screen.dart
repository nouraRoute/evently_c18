import 'package:evently_c18/common/gen/assets.gen.dart';
import 'package:evently_c18/common/theme/app_colors.dart';
import 'package:evently_c18/common/utils/validation_utils.dart';
import 'package:evently_c18/common/widgets/custom_filled_button.dart';
import 'package:evently_c18/common/widgets/custom_outlined_button.dart';
import 'package:evently_c18/common/widgets/custom_text_field.dart';
import 'package:evently_c18/models/custom_user_model.dart';
import 'package:evently_c18/network/auth_service.dart';
import 'package:evently_c18/screens/auth/login_screen.dart';
import 'package:evently_c18/screens/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "/registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reEnterPAssword = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15,
              ),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                    controller: name,
                    validator: (value) {
                      if (ValidationUtils.validateEmptyText(value) == false) {
                        return "empty Name!";
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Enter your Email",
                    prefixIconPath: Assets.icons.sms.path,
                    controller: email,
                    validator: (value) {
                      if (ValidationUtils.validateEmptyText(value) == false) {
                        return "empty email!!";
                      } else if (ValidationUtils.validateEmail(value!) ==
                          false) {
                        return "invalid email";
                      }
                    },
                  ),

                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Enter your Password",
                    prefixIconPath: Assets.icons.lock.path,
                    isPassword: true,
                    controller: password,
                    validator: (value) {
                      if (ValidationUtils.validateEmptyText(value) == false) {
                        return "empty password!!";
                      } else if (ValidationUtils.validatePassword(value!) ==
                          false) {
                        return "invalid password ,atheist 5characters";
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Confirm your password",
                    prefixIconPath: Assets.icons.lock.path,
                    isPassword: true,
                    controller: reEnterPAssword,
                    validator: (value) => value != password.text
                        ? "password doesnot match"
                        : null,
                  ),
                  SizedBox(height: 50),

                  CustomFilledButton(
                    isLoading: isLoading,
                    text: "Sign up",
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        String? errorMEssage = await AuthService.register(
                          CustomUserModel(email: email.text, name: name.text),
                          password.text,
                        );
                        setState(() {
                          isLoading = false;
                        });
                        if (errorMEssage != null) {
                          Fluttertoast.showToast(
                            msg: errorMEssage,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          if (context.mounted) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(LoginScreen.routeName);
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
      ),
    );
  }
}
