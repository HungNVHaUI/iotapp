import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
 class TElevatedButtonTheme {
   TElevatedButtonTheme._();
   static final lightElevatedButtonTheme = ElevatedButtonThemeData(
     style: OutlinedButton.styleFrom(
         elevation: 0,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
         foregroundColor: tWhiteColor,
         backgroundColor: tSecondaryColor,
         side: BorderSide(color: tSecondaryColor),
         padding: EdgeInsets.symmetric(vertical: 15.0)
     ),
   );
   static final darkElevatedButtonTheme = ElevatedButtonThemeData(
     style: OutlinedButton.styleFrom(
         elevation: 0,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
         foregroundColor: tSecondaryColor,
         backgroundColor: tWhiteColor,
         side: BorderSide(color: tWhiteColor),
         padding: EdgeInsets.symmetric(vertical: 15.0)
     ),
   );
 }