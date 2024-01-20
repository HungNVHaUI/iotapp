import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testapp/src/constants/image_strings.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';
import 'package:testapp/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';

import '../../../../common_widgets/form/form_header_widget.dart';
import '../login/login_screen.dart';



class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super (key : key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
                const FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                  ),
              const SignUpFormWidget(),
              Column(
                children: [
                  const Text('OR'),
                  SizedBox(
                    width: double.infinity,
                    child:OutlinedButton.icon(
                        onPressed: (){},
                        icon: const Image(image: AssetImage(tGoogleLogoImage),width: 20.0),
                        label: const Text('Sign Up With Google'),
                    ),
                  )
                ],
              ),
              TextButton(onPressed: (){ Get.to(LogInScreen());},
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: tAlreadyHaveAnAccount, style: Theme.of(context).textTheme.bodyText1),
                        TextSpan(text: tLogIn),
                      ]
                    )

                  )
              ),

            ],
          ),
        )
      ),
    );
  }
}

