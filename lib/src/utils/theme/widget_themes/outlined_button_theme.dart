import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
class TOutlineButtonTheme {
  TOutlineButtonTheme._();
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          foregroundColor: tSecondaryColor,
          side: BorderSide(color: tSecondaryColor),
          padding: EdgeInsets.symmetric(vertical: 15.0)
      ),
  );
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        foregroundColor: tWhiteColor,
        side: BorderSide(color: tWhiteColor),
        padding: EdgeInsets.symmetric(vertical: 15.0)
    ),
  );
}