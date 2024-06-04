import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';

void showUploadSuccessDialog(
    {required BuildContext context,
    required double width,
    required double height,
    required bool isUpdate,String? text}) {

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
            constraints: BoxConstraints(maxWidth: width * 0.6, maxHeight: width * 0.46),
            width: width * 0.445,
            // height: width * 0.45,
            alignment: Alignment.center,
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
                    Image.asset(AssetRes.editImg, height: width*0.2, width:  width*0.2),
                    SizedBox(height: width * 0.04),
                    Text(
                     text != null ? text : isUpdate == true
                          ? "iconUpdatedSuccessfully".tr
                          : "iconUploadedSuccessfully".tr,
                      style: regularFontStyle(size: 19),
                    ),
                    SizedBox(height: width * 0.035),
                    CommonPrimaryButton(
                        text: "    ${'ok'.tr}    ",
                        onTap: () {
                          Navigator.pop(context);
                          if(text != null)
                            {
                          Navigator.pop(context);

                            }
                        }),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
