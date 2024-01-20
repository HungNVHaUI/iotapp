import 'package:flutter/material.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/features/authentication/screens/Login/widgets/login_header_widget.dart';
import 'package:testapp/src/features/authentication/screens/login/widgets/login_form_widget.dart';



class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super (key : key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginHeaderWidget(),
                LoginFormWidget(),


              ],
            ),
          )
      ),
    );
  }
}