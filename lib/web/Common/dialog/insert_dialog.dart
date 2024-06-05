
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_methods.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';

void showInsertDialog(
    {required BuildContext context,
    required double width,
    required double height,
    required RxString imageUrl,required TextEditingController textController,required final VoidCallback onTap,required RxBool isLoading}) {

  ThemeController themeController = Get.find<ThemeController>();

  showDialog(
    context: context,
    //barrierColor: themeController.c.value,

    builder: (BuildContext context) {

      return AlertDialog(



         backgroundColor: themeController.c.value,

        contentPadding: EdgeInsets.zero,

        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeController.c.value,          ),
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: width * 0.02)
              .copyWith(top: width * 0.012),

          constraints: BoxConstraints(maxWidth: width * 0.55, maxHeight: width * 0.51),
          width: width * 0.53,
          // height: width * 0.51,
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upload Icon".tr,
                    style: regularFontStyle(size: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                  Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 3, bottom: 3, top: 2),
                      color: Colors.transparent,
                      child: Icon(Icons.close, color: appTheme.dotted,size: 27),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: width * 0.032,
              ),
              Row(
                children: [
                  SizedBox(width: width * 0.02),
                  Text(
                    "name".tr,
                    style: regularFontStyle(size: 18),
                  ),
                  SizedBox(width: width * 0.027),
                  Expanded(
                    child: CommonTextFiled(hintext: "enterName".tr,controller: textController,inputFormatter: [CustomInputFormatterTextOnly()],),
                  ),
                  SizedBox(width: width * 0.02),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: DottedBorder(
                  borderType: BorderType.Rect,
                  borderPadding: EdgeInsets.symmetric(horizontal: 3),
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  color: appTheme.dotted,
                  dashPattern: [10, 6],
                  strokeWidth: 1,
                  child: Container(
                    width: double.infinity,
                    height: width * 0.2,
                    decoration: BoxDecoration(
                      color: themeController.c.value//appTheme.colorFAFAFA,
                    ),
                    padding: EdgeInsets.only(
                        top: width * 0.015, bottom: width * 0.015),
                    child: Obx(
                      () => imageUrl.value.isNotEmpty
                          ? Stack(
                        alignment: Alignment.center,
                              children: [
                                Image.network(imageUrl.value),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      imageUrl.value = "";
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: width*0.015),
                                      decoration: BoxDecoration(
                                        color: appTheme.red700
                                      ),
                                      padding: EdgeInsets.all(3),
                                      child: Icon(Icons.close,color: appTheme.white,size: 20),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                // CommonPrimaryButton(
                                //   text: 'browse'.tr,
                                //   onTap: () {
                                //     pickImage(imageUrl);
                                //   },
                                // ),
                                GestureDetector(
                                  onTap: (){
                                    pickImage(imageUrl);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: Get.width,
                                    child: Image.asset(
                                        AssetRes
                                            .addImageIcon,
                                        scale: 4, color: appTheme.themeColor),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),




              Spacer(),
              // SizedBox(height: width*0.032),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () =>  CommonPrimaryButton(
                      text: "lbl_upload".tr,
                      onTap: () {
                        if(imageUrl.value.isEmpty)
                        {
                          errorToast("Please upload icon");
                        }
                        else if(textController.text.trim().isEmpty){
                          errorToast("Please enter sport name");
                        } else{
                          onTap();
                        }
                      },
                      isLoading: isLoading.value,
                    ),
                  ),
                  // SizedBox(width: width * 0.02),
                  // CommonPrimaryButton(
                  //     text: "lbl_cancel".tr,
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },
                  //     color: themeController.c.value,//appTheme.white,
                  //     textColor: themeController.d.value//appTheme.black
                  // ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}


