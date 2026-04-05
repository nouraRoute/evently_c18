import 'package:evently_c18/common/theme/app_colors.dart';
import 'package:evently_c18/common/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      primary: AppColors.mainLightMode,
      seedColor: AppColors.mainLightMode,
      brightness: Brightness.light,
      inversePrimary: AppColors.mainLightMode,
    ),
    disabledColor: AppColors.disable,
    hintColor: AppColors.secTextLightMode,
    cardColor: Colors.white,
    dividerColor: AppColors.strokeLightMode,
    scaffoldBackgroundColor: AppColors.lightBg,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.style18w500Black.copyWith(
        color: AppColors.mainTextLightMode,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: "Poppins",
        color: AppColors.mainLightMode,
      ),
      selectedItemColor: AppColors.mainLightMode,
      unselectedItemColor: AppColors.disable,
      unselectedLabelStyle: AppTextStyles.style12w400Black.copyWith(
        color: AppColors.disable,
      ),
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.strokeLightMode),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.mainLightMode,
        ),
      ),
    ),
    textTheme: _generateTextTheme(AppColors.mainTextLightMode),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainLightMode),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      primary: AppColors.mainDarkMode,
      seedColor: AppColors.mainDarkMode,
      brightness: Brightness.dark,
      inversePrimary: Colors.white,
    ),

    hintColor: AppColors.secTextDarkMode,
    disabledColor: AppColors.disable,
    dividerColor: AppColors.strokeDarkMode,
    cardColor: AppColors.inputs,
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: AppTextStyles.style18w500Black.copyWith(
        color: AppColors.mainTextDarkMode,
      ),
      backgroundColor: AppColors.darkBg,
      elevation: 0,
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) => Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.inputs,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.strokeDarkMode),
        ),
        child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: AppTextStyles.style12w400Black.copyWith(
        color: AppColors.mainDarkMode,
      ),
      unselectedLabelStyle: AppTextStyles.style12w400Black.copyWith(
        color: AppColors.disable,
      ),
    ),
    textTheme: _generateTextTheme(AppColors.mainTextDarkMode),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainDarkMode),
    ),
  );

  static TextTheme _generateTextTheme(Color color) {
    return TextTheme(
      displayLarge: AppTextStyles.style24w600Black.copyWith(color: color),
      displayMedium: AppTextStyles.style20w600Black.copyWith(color: color),
      headlineLarge: AppTextStyles.style18w600Black.copyWith(color: color),
      headlineMedium: AppTextStyles.style18w500Black.copyWith(color: color),
      headlineSmall: AppTextStyles.style18w400Black.copyWith(color: color),
      titleLarge: AppTextStyles.style16w600Black.copyWith(color: color),
      titleMedium: AppTextStyles.style16w500Black.copyWith(color: color),
      titleSmall: AppTextStyles.style16w400Black.copyWith(color: color),
      labelLarge: AppTextStyles.style14w600Black.copyWith(color: color),
      labelMedium: AppTextStyles.style14w500Black.copyWith(color: color),
      labelSmall: AppTextStyles.style14w400Black.copyWith(color: color),
      bodyLarge: AppTextStyles.style12BoldBlack.copyWith(color: color),
      bodyMedium: AppTextStyles.style12w500Black.copyWith(color: color),
      bodySmall: AppTextStyles.style12w400Black.copyWith(color: color),
    );
  }
}
