import 'package:flutter/material.dart';
import 'package:testapp/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:testapp/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:testapp/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:testapp/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TTextTheme.lightTextTheme,
      outlinedButtonTheme: TOutlineButtonTheme.lightOutlineButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      outlinedButtonTheme: TOutlineButtonTheme.darkOutlineButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}