import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testapp/src/constants/colors.dart';

import '../../../constants/image_strings.dart';
import '../../core/screens/profile/profile_screen.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSizeWidget {

  const DashBoardAppBar({
    Key? key,
    required this.isDark,
    }) : super (key: key);

final bool isDark;

  @override
  Widget build(BuildContext context) {
    return AppBar(

      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: Icon(Icons.menu, color: isDark ? tWhiteColor: tDarkColor),
      title: Text("App Name", style: Theme.of(context).textTheme.headline4,),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDark ? tSecondaryColor : tCardBgColor,
          ),
          child: IconButton(
            onPressed: () {
              // AuthenticationRepository.instance.logout();
              Get.to(ProfileScreen());
            },
            icon: const Image(image: AssetImage(tUserProfileImage)),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);


}
