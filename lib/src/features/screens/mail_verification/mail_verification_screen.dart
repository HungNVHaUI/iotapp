import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';
import 'package:testapp/src/features/screens/welcome/welcome_screen.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';



class MailVerification extends StatelessWidget {
  const MailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LineAwesomeIcons.envelope_open, size: 100,),
                const SizedBox(height: 50.0),
                Text(tEmailVerification, style: Theme.of(context).textTheme.bodyText2,),
                const SizedBox(height: 30.0),

                TextButton(
                  onPressed: () {
                    AuthenticationRepository.instance.logout();
                    Get.to(WelcomeScreen());
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                         TextSpan(text: tLoginOrSignup),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AuthenticationRepository.instance.reloadUser();
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text:"Reload"),
                      ],
                    ),
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
