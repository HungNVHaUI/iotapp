import 'package:flutter/material.dart';
import 'package:testapp/src/common_widgets/form/form_header_widget.dart';
import 'package:testapp/src/constants/image_strings.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),

            child: Column (
              children:  [
                const SizedBox(height: tDefaultSize * 4),
                const  FormHeaderWidget(
                  image: tForgetPasswordImage,
                  title: tForgetPassword,
                  subTitle: tForgetPasswordSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: tFormHeight),
                Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text(tPhoneNo),
                            hintText: tPhoneNo,
                            prefixIcon: Icon(Icons.phone_android),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(width: double.infinity ,child: ElevatedButton(onPressed: (){}, child: const  Text(tNext))),
                      ],))

              ],
            ),
          ),
        ),
      ),
    );
  }
}