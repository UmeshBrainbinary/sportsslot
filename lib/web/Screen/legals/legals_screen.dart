import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/web/Common/custom_switch.dart';
import 'package:sportsslot/web/Common/dialog/logout_dialog.dart';
import 'package:sportsslot/web/Screen/about/about_screen.dart';
import 'package:sportsslot/web/Screen/faqs/faq_screen.dart';
import 'package:sportsslot/web/Screen/notification/notification_screen.dart';
import 'package:sportsslot/web/Screen/privacy_policy/privacy_policy_screen.dart';
import 'package:sportsslot/web/Screen/setting/setting_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LegalsScreen extends StatelessWidget {
  LegalsScreen({super.key});

  SettingController controller = Get.put(SettingController());
  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        if (sizingInformation.isDesktop) {
          width = 800;
          height = 950;
        } else if (sizingInformation.isTablet) {
          width = 550;
          height = 900;
        } else if (sizingInformation.isMobile) {
          width = 350;
        }

        return Obx(
          () =>  Container(
            color: themeController.webBgColor.value,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 27),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                      "lbl_legals".tr,
                            style: mediumFontStyle(size: 24),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 8),

                    Padding(
                      padding:  EdgeInsets.only(top: height*0.075,left: width*0.04, right: width*0.04),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.to(
                                transition: Transition.noTransition,
                                    () => NotificationScreen(),
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),color: themeController.c.value,
                                    boxShadow: [
                                       BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 20.0,
                                        spreadRadius: 2
                                    ),]
                                ),
                                padding: EdgeInsets.symmetric(horizontal: width*0.055,vertical: width*0.02),
                                child: Row(
                                  children: [
                                    Text("notification".tr,
                                      textAlign: TextAlign.start,
                                      style: regularFontStyle(
                                          size: 20,
                                          color: themeController.d.value,
                                          sizingInformation:
                                          sizingInformation),
                                    ),
                                    const Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded, color: appTheme.themeColor)
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: (){
                              Get.to(
                                  transition: Transition.noTransition,
                                      ()=>PrivacyPolicyScreen());
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),color: themeController.c.value,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 20.0,
                                          spreadRadius: 2
                                      ),]
                                ),
                                padding: EdgeInsets.symmetric(horizontal: width*0.055,vertical: width*0.02),
                                child: Row(
                                  children: [
                                    Text("privacyPolicy".tr,
                                      textAlign: TextAlign.start,
                                      style: regularFontStyle(
                                          size: 20,
                                          color: themeController.d.value,
                                          sizingInformation:
                                          sizingInformation),
                                    ),
                                    const Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded, color: appTheme.themeColor)
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: (){
                              Get.to(
                                  transition: Transition.noTransition,
                                      ()=>FaqScreen());
                            },
                            child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: themeController.c.value,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 20.0,
                                          spreadRadius: 2
                                      ),]
                                ),
                                padding: EdgeInsets.symmetric(horizontal: width*0.055,vertical: width*0.02),
                                child: Row(
                                  children: [
                                    Text( "faqs".tr,
                                      textAlign: TextAlign.start,
                                      style: regularFontStyle(
                                          size: 20,
                                          color: themeController.d.value,
                                          sizingInformation:
                                          sizingInformation),
                                    ),
                                    const Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded, color: appTheme.themeColor)
                                  ],
                                )
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: (){
                              Get.to(
                                  transition: Transition.noTransition,
                                      ()=>AboutScreen());
                            },
                            child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    color: themeController.c.value,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 20.0,
                                          spreadRadius: 2
                                      ),]
                                ),
                                padding: EdgeInsets.symmetric(horizontal: width*0.055,vertical: width*0.02),
                                child: Row(
                                  children: [
                                    Text("lbl_about_us".tr,
                                      textAlign: TextAlign.start,
                                      style: regularFontStyle(
                                          size: 20,
                                          color: themeController.d.value,
                                          sizingInformation:
                                          sizingInformation),
                                    ),
                                    const Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded, color: appTheme.themeColor)
                                  ],
                                )
                            ),
                          ),
                        ],
                      )
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
