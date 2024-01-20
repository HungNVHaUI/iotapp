import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/src/constants/image_strings.dart';
import 'package:testapp/src/constants/sizes.dart';
import 'package:testapp/src/constants/text_strings.dart';
import '../../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super (key : key);
  final splashController = Get.put(SplashScreenController());


  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => AnimatedPositioned (
                duration: const Duration(milliseconds: 1600),
                top: splashController.animate.value ? 0 : -30,
                left: splashController.animate.value ? 0 : -30,
                child:const Image(
                  image: AssetImage(tSplashTopIcon),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            Obx(() => Positioned (
                top: 50,
                left: tDefaultSize,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 :0 ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tAppName,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        tAppTagLine,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => AnimatedPositioned (
                bottom: 100,
                duration: const Duration(milliseconds: 1600),
                left: splashController.animate.value ? 140 : 0,
                child:const Image(
                  image: AssetImage(tSplashImage),
                  width: 250,
                  height: 250,
                ),
              ),
            ),
            // Obx(() => Positioned (
            //     bottom: 10,
            //     right: tDefaultSize,
            //     child: Container(
            //       width: tSplashContainerSize,
            //       height: tSplashContainerSize,
            //       decoration: BoxDecoration(
            //         color: tPrimaryColor,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }


}

