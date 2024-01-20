import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:testapp/src/constants/colors.dart';
import 'package:testapp/src/constants/image_strings.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';
import 'package:testapp/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:testapp/src/features/core/screens/profile/widget/profile_menu.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../../screens/welcome/welcome_screen.dart';



class ProfileScreen extends StatelessWidget{
  const ProfileScreen ({Key? key}): super (key: key);


  @override
  Widget build(BuildContext context){
    // final txtTheme = Theme.of(context).textTheme;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(),icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tProfile, style: Theme.of(context).textTheme.headline4,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(isDark? LineAwesomeIcons.sun : LineAwesomeIcons.moon ))
        ],
      ),
      body:  SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(image: AssetImage(tProfileImage)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: tPrimaryColor,
                            ),
                            child:  const Icon(LineAwesomeIcons.alternate_pencil,size: 20.0,color: Colors.black)),
                      )
                    ],
                  ),

                  const SizedBox(height: 10.0),
                  Text(tProfileHeading, style: Theme.of(context).textTheme.headline4,),
                  Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyText2,),
                  const SizedBox(height: 30.0),
                  // SizedBox(
                  //   width: 200,
                  //   child: ElevatedButton(
                  //     onPressed: () => Get.to(() => UpdateProfileScreen()),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: tPrimaryColor,
                  //       side: BorderSide.none,
                  //       shape: const StadiumBorder(),
                  //     ),
                  //     child: const Text(tEditProfile, style: TextStyle(color: tDarkColor),),
                  //   ),
                  // ),
                  const SizedBox(height: 20,),
                  const Divider(),
                  const SizedBox(height: 20,),
                  ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog,onPress: () => Get.to(() => UpdateProfileScreen())),
                  // ProfileMenuWidget(title: "Billing Details",icon: LineAwesomeIcons.wallet,onPress: (){}),
                  ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check,onPress: (){}),

                  const SizedBox(height: 180,),
                  const Divider(),
                  const SizedBox(height: 20,),
                  ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info,onPress: (){}),
                  ProfileMenuWidget(
                      title: "Logout",
                      icon: LineAwesomeIcons.alternate_sign_out,
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: (){AuthenticationRepository.instance.logout();
                        Get.offAll(() => WelcomeScreen());}
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

