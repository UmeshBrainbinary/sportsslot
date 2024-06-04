import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Screen/notification/notification_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  NotificationController controller = Get.put(NotificationController());
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
                            'notification'.tr,
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
                            SizedBox(height: height*0.01),
                            Row(
                              children: [
                                Text("title".tr,style: regularFontStyle(size: 18),),
                                Text(" *",style: regularFontStyle(size: 18,color: appTheme.colorFF0101)),
                              ],
                            ),
                            SizedBox(height: height*0.01),
                            CommonTextFiled(hintext: "Please enter title",controller: controller.titleController,maxLine: 1,textHeight: 1.2,),
                            SizedBox(height: 3),
                            Obx(() => controller.titleError.value.isNotEmpty ? Text(controller.titleError.value,style: errorTextStyle()) : SizedBox()),
                            SizedBox(height: height*0.025),
                            Row(
                              children: [
                                Text("description".tr,style: regularFontStyle(size: 18),),
                                Text(" *",style: regularFontStyle(size: 18,color: appTheme.colorFF0101)),
                              ],
                            ),
                            SizedBox(height: height*0.01),
                            CommonTextFiled(hintext: "enter_description".tr,controller: controller.descriptionController,maxLine: 1,textHeight: 1.3,),
                            SizedBox(height: 3),
                            Obx(() => controller.descError.value.isNotEmpty ? Text(controller.descError.value,style: errorTextStyle()) : SizedBox()),
                            SizedBox(height: height*0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                      () =>  CommonPrimaryButton(text: " ${"sendNotification".tr} ",onTap: () async {
                                      controller.validate();
                                    if(controller.titleError.value.isEmpty && controller.descError.value.isEmpty)
                                    {
                                      controller.loader.value = true;
                                      List<String> fcmList= await controller.getFcmTokens();
                                      await controller.sendNotification(fcmTokens: fcmList, title: controller.titleController.text.trim(), body: controller.descriptionController.text.trim());
                                      controller.loader.value = false;
                                      // ACTION
                                    }
                                    else{
                                      // showToast("Description updated successfully");
                                    }
                                  },isLoading: controller.loader.value),
                                ),
                              ],
                            ),
                            SizedBox(height: height*0.01),
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
