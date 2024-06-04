import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Common/custom_switch.dart';
import 'package:sportsslot/web/Screen/login_screen/login_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double width = 0;
  double height = 0;

  LoginController loginController = Get.put(LoginController());
  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.isDesktop) {
        width = 700;
        height = 1000;
      } else if (sizingInformation.isTablet) {
        width = 500;
        height = 900;
      } else if (sizingInformation.isMobile) {
        width = 350;
        height = 750;
      }

      return GetBuilder<LoginController>(
        id: "login",
        builder: (controller) => Scaffold(
          body: Obx(() => Container(
            width: size.width,
            color: themeController.webBgColor.value,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: themeController.drawerBgColor.value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Center(
                            child: Column(
                              children: [
                                Container(
                                    height: size.height / 5,
                                    child: Image.asset(AssetRes.logo)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('PlaygroundBooking'.tr,
                                    style: semiBoldFontStyle(
                                        size: 23,
                                        sizingInformation: sizingInformation)),
                                SizedBox(height: height * 0.03),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: width * 0.034),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.05),
                                Text('EmailAddress'.tr,
                                    style: regularFontStyle(size: 15)),
                                SizedBox(
                                  height: 8,
                                ),
                                CommonTextFiled(
                                  hintext: 'abc@gmail.com',
                                  controller: loginController.emailController,
                                ),
                                loginController.emailError.isEmpty
                                    ? const SizedBox()
                                    : Text(
                                  loginController.emailError,
                                  style: const TextStyle(
                                      fontFamily: 'FontMedium',
                                      fontSize: 13,
                                      color: Colors.red),
                                ),

                                SizedBox(height: 15),

                                Text('Password'.tr,
                                    style: regularFontStyle(size: 15)),
                                SizedBox(height: 8),
                                CommonTextFiled(
                                  hintHeight: 3,
                                  icon: Icons.remove_red_eye_outlined,
                                  maxLine: 1,
                                  obscureText: loginController.passView,
                                  hintext: '••••••',
                                  controller:
                                  loginController.passwordController,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      loginController.passView =
                                      !loginController.passView;
                                      loginController.update(["login"]);
                                    },
                                    child: Container(
                                      child: loginController.passView
                                          ? Image.asset(AssetRes.closeEye,
                                          scale: 4,color: themeController.hintColor.value)
                                          : Image.asset(AssetRes.openEye,
                                          scale: 2.5,color: themeController.hintColor.value),
                                    ),
                                  ),
                                ),

                                // CommonTextFiled(
                                //
                                //   icon: Icons.remove_red_eye_outlined,
                                //   controller: loginController.passwordController,
                                //   obscureText: loginController.passView,
                                //   hintHeight: 2,
                                //   maxLine:1,
                                //   suffixIcon: GestureDetector(
                                //     onTap: () {
                                //       loginController.passView = !loginController.passView;
                                //       loginController.update(["login"]);
                                //     },
                                //     child: Container(
                                //       child: loginController.passView ? Image.asset(AssetRes.closeEye,scale: 4) : Image.asset(AssetRes.openEye,scale: 2.5),
                                //     ),
                                //   ), hintext: '.....',
                                // ),
                                loginController.passwordError.isEmpty
                                    ? const SizedBox()
                                    : Text(
                                  loginController.passwordError,
                                  style: const TextStyle(
                                      fontFamily: 'FontMedium',
                                      fontSize: 13,
                                      color: Colors.red),
                                ),

                                SizedBox(height: 40),

                                SizedBox(
                                  height: 50,
                                  width: width,
                                  child: Obx(
                                        () => CommonPrimaryButton(
                                      text: 'Login'.tr,
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();

                                        await loginController.emailValidation();
                                        await loginController
                                            .passwordValidation();

                                        if (loginController
                                            .emailError.isEmpty &&
                                            loginController
                                                .passwordError.isEmpty) {
                                          await controller
                                              .loginWithEmailAndPassword();

                                          // if(isSuccess)
                                          //   {

                                          // }
                                        }
                                      },
                                      isLoading: controller.loader.value,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 0),
                          SizedBox(height: 0),
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage(AssetRes.loginBg),
                      // ),

                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.0065,
                          vertical: height * 0.011),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Obx(
                                  () => CustomSwitch(
                                value: themeController.isDarkMode.value,
                                onChanged: (value) {
                                  debugPrint("-=-=-=-=-=-: ${value}");
                                  themeController.isDarkMode.value = value;
                                  themeController.switchTheme();
                                },
                              ),
                            ),
                          ),
                          Spacer(),
                          // SizedBox(
                          //   height: size.width / 9,
                          // ),
                          Container(
                            // height: size.width / 3.5,
                              child: Image.asset(AssetRes.Groups, scale: 4.3)),
                          SizedBox(height: Get.height * 0.04),
                          // SizedBox(
                          //   height: size.width / 25,
                          // ),
                          Text('Playground'.tr,
                              style: semiBoldFontStyle(
                                  size: 35,
                                  sizingInformation: sizingInformation)

                            // style: TextStyle(
                            //     color: ColorRes.Text,
                            //     fontSize: 25,
                            //     fontWeight: FontWeight.w600,
                            //     fontFamily: Family.robotRegular),
                          ),
                          // SizedBox(height: Get.height*0.07),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),)
        ),
      );
    });
  }
}
