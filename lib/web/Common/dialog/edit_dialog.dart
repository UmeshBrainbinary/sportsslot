import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_methods.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';

import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';

void showEditDialog(
    {required BuildContext context,
      required double width,
      required double height,required String image,required RxString imageUrl,required TextEditingController textController,required final VoidCallback onTap,required RxBool isLoading}) {

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
                    "editIcon".tr,
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
                height: width * 0.0325,
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
                        top: width * 0.013, bottom: width * 0.013),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                              () =>  imageUrl.value.isNotEmpty
                              ? Image.network(imageUrl.value): Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

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
                        Obx(
                              () =>imageUrl.value.isNotEmpty ?  Align(
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
                          ) : Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(right: width*0.013),
                              height: 33,
                              width: 33,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: appTheme.colorE6F6F5,
                                  border: Border.all(color: appTheme.colorB3B3BF,width: 0.5),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Image.network(image),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () =>  CommonPrimaryButton(
                      text: "lbl_upload".tr,
                      onTap: () {
                     /*   if(imageUrl.value.isEmpty)
                        {
                          errorToast("Please upload image");
                        }
                        else */
                        if(textController.text.trim().isEmpty){
                          errorToast("Please enter sport name");
                        }
                        else{
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
                  //     textColor: themeController.d.value,//appTheme.black
                  // ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}