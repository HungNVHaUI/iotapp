import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/src/constants/colors.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';

import '../../../constants/image_strings.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../../authentication/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor: tWhiteColor,
      body: Container(
        padding:const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image:const AssetImage(tWelcomeScreenImage), height: height*0.6),
            const Column(
              children: [
                Text(tWelcomeTitle),
                Text(tWelcomeSubTitle),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () {Get.to(LogInScreen());},
                        child: Text(tLogIn.toUpperCase()),
                    )
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {Get.to(SignUpScreen());},
                        child: Text(tSignUp.toUpperCase())
                    ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}
