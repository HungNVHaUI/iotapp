import 'package:flutter/material.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/text_strings.dart';



class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({Key? key}) : super (key : key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(tWelcomeScreenImage),
          height: size.height * 0.2,
        ),
        Text(tFormTitle, style: Theme.of(context).textTheme.headline1),
        Text(tFormSubTitle,style: Theme.of(context).textTheme.bodyText1),

      ],
    );


  }
}