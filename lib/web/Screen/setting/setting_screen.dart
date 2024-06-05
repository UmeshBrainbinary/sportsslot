import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/Wrb_font_Family/Font_family.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Common/custom_switch.dart';
import 'package:sportsslot/web/Common/dialog/logout_dialog.dart';

import 'package:sportsslot/web/Screen/setting/setting_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

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
                      "lbl_settings".tr,
                            style: mediumFontStyle(size: 24),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 8),

                    Padding(
                      padding:  EdgeInsets.only(top: height*0.075,left: width*0.04,right: width*0.04),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: themeController.c.value//appTheme.white
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width*0.055,vertical: width*0.02).copyWith(bottom: width*0.013),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Change Mode",
                                  textAlign: TextAlign.start,
                                  style: regularFontStyle(
                                      size: 20,
                                      color: themeController.d.value,
                                      sizingInformation:
                                      sizingInformation),
                                ),
                                SizedBox(width: 50),
                                Obx(
                                      () => CustomSwitch(
                                    value: themeController.isDarkMode.value,
                                    onChanged: (value) {
                                      debugPrint("-=-=-=-=-=-: ${value}");
                                      themeController.isDarkMode.value = value;
                                      themeController.switchTheme();
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Logout",
                                  textAlign: TextAlign.start,
                                  style: regularFontStyle(
                                      size: 20,
                                      color: themeController.d.value,
                                      sizingInformation:
                                      sizingInformation),
                                ),
                                SizedBox(
                                  width: 110,
                                ),


                               GestureDetector(
                                 onTap: (){
                                   showLogoutSuccessDialog(
                                       context: context, width: width, height: width);
                                 },
                                 child:  Image.asset(AssetRes.logout,  color: appTheme.themeColor, height: 50,),
                               ),


                              ],
                            )
                          ],
                        ),
                      ),
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
