
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';
import 'package:testapp/src/features/screens/forget_password/forget_password_options/forget_password_btn_widget.dart';

import '../forget_password_email/forget_password_email.dart';
import '../forget_password_phone/forget_password_phone.dart';

class ForgetPasswordScreen{

  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tForgetPasswordTitle, style: Theme.of(context).textTheme.headline2 ),
            Text(tForgetPasswordSubTitle, style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 30.0),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: tEmail,
              subTitle: tResetViaEmail,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ForgetPasswordEmailScreen());
                },
            ),
            const SizedBox(height: 20.0),
            ForgetPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_outlined,
              title: tPhoneNo,
              subTitle: tResetViaEmail,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const ForgetPasswordPhoneScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}