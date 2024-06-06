// ignore_for_file: deprecated_member_use

import 'package:lottie/lottie.dart';

import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  SplashController controller = Get.put(SplashController());

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: ()async {
        closeApp();
        return false;
      },
      child: Scaffold(
        backgroundColor: appTheme.bgColor,
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: AssetRes.logo,
                    height: Get.height*0.15
                ),

                // Center(
                //   child: Lottie.asset(
                //     ImageConstant.splashAnimation,
                //     controller: _controller,
                //     onLoaded: (composition) {
                //       _controller
                //         ..duration = composition.duration
                //         ..repeat();
                //     },
                //   ),
                // ),
                SizedBox(height: 20.v),
                Text(
                  "msg_sportsslot".tr,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: appTheme.black900,
                      fontFamily: 'Montserrat-Medium',
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


