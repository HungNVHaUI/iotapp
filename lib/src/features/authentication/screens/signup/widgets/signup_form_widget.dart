
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';
import 'package:testapp/src/features/authentication/models/user_model.dart';
import '../../../controller/signup_controller.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}-${now.month}-${now.year}';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(labelText: tFullName, prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: tFormHeight - 20.0),
            TextFormField(
              controller: controller.email,
              decoration:const InputDecoration(labelText: tEmail, prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: tFormHeight - 20.0),
            TextFormField(
              controller: controller.phoneNo,
              decoration:const InputDecoration(labelText: tPhoneNo, prefixIcon: Icon(Icons.phone_android)),
            ),
            const SizedBox(height: tFormHeight - 20.0),
            TextFormField(
              controller: controller.password,
              obscureText: _obscureText,
              decoration: InputDecoration(labelText: tPassword, prefixIcon: Icon(Icons.fingerprint),
                suffixIcon: GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 10.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if( _formKey.currentState!.validate()){
                    //Signup email and password
                    // SignUpController.instance.registerUser(
                    //     controller.email.text.trim(),
                    //     controller.password.text.trim(),);


                    //Signup phoneNo
                    // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                    // Get.to(() => const OTPScreen());
                    final user = UserModel(
                        email: controller.email.text.trim(),
                        fullName: controller.fullName.text.trim(),
                        phoneNo: controller.phoneNo.text.trim(),
                        password: controller.password.text.trim(),
                        joinedAt: formattedDate,
                      devices:[],
                    );
                    SignUpController.instance.createUserMail(user);
                  }
                },
                child: Text(tSignUp.toUpperCase()),
              ),

            ),
          ],
        ),
      ),
    );
  }
}





