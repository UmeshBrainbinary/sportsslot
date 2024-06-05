import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';

void showDeleteSuccessDialog(
    {required BuildContext context,
      required double width,
      required double height,required VoidCallback onTap,required RxBool isLoading, String? msg}) {
  ThemeController themeController = Get.find<ThemeController>();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: width * 0.02)
                .copyWith(top: width * 0.012),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeController.c.value,          ),
            constraints:
            BoxConstraints(maxWidth: width * 0.6, maxHeight: height * 0.35),
            width: width * 0.49,

            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 3, bottom: 3, top: 2),
                          color: Colors.transparent,
                          child: Icon(Icons.close, color: appTheme.dotted,size: 25),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: width * 0.007,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetRes.deleteImg, height: width*0.1, width:width*0.1),
                      SizedBox(height: width * 0.047),
                      // Spacer(),
                      Text(msg ?? "confirmDeleteIcon".tr,
                        style: regularFontStyle(size: 16),
                      ),
                      SizedBox(height: width * 0.038),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () =>  CommonPrimaryButton(
                                text: " ${'yes'.tr} ",
                                onTap:onTap,isLoading: isLoading.value),
                          ),
                          SizedBox(width: width*0.02),
                          CommonPrimaryButton(
                            color: themeController.c.value,//appTheme.white,
                              textColor: themeController.d.value,//appTheme.black,
                              text: " ${'no'.tr} ",
                              onTap: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
