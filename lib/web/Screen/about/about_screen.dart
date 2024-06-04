import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/about/about_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AboutController controller = Get.put(AboutController());

  ThemeController themeController = Get.find<ThemeController>();

  QuillEditorController richTextController = QuillEditorController();


  @override
  void initState() {
    initEditor();
    controller.init();
    ever(themeController.isDarkMode, (bool isDarkMode) {
      changeTheme();
      // setState(() {
      //   initEditor();
      //
      //   debugPrint("-=-=-=-=->>>>>>>>>: ${isDarkMode}");
      // });
    });
    super.initState();
  }

Future<void> changeTheme() async{
  controller.loader.value = true;
  await Future.delayed(Duration(seconds: 1),(){});
  initEditor();
  controller.loader.value = false;
  setState(() {});
}
  @override
  void dispose() {
    richTextController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    controller.descController.clear();
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
                            'lbl_about_us'.tr,
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
                          children: [
                            SizedBox(height: height*0.01),
                              Row(
                                children: [
                                  Text("description".tr,style: regularFontStyle(size: 21),),
                                  Text(" *",style: regularFontStyle(size: 21,color: appTheme.colorFF0101)),
                                ],
                              ),

                            SizedBox(height: height*0.02),
                            Obx(
                              () =>  ToolBar(
                                toolBarColor:themeController.textfieldBgColor.value,
                                padding: const EdgeInsets.all(8),
                                iconSize: 25,
                                iconColor: themeController.toolbarIconColor.value,
                                activeIconColor: appTheme.themeColor,
                                controller: richTextController,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                toolBarConfig: controller.customToolBarList,
                                // customButtons: [],
                              ),
                            ),
                            SizedBox(height: height*0.02),
                            Obx(
                              () => Container(
                                height: height*0.52,
                                color: themeController.textfieldBgColor.value,
                                child:
                                Obx(
                                      () => controller.loader.value ? CommonLoader():  QuillHtmlEditor(
                                    text: controller.htmlResponseForEdit.value,
                                    hintText: 'Please enter privacy policy',
                                    controller: richTextController,
                                    isEnabled: true,
                                    ensureVisible: false,
                                    minHeight: height*0.52,
                                    autoFocus: false,
                                    textStyle: regularFontStyle(size: 16,color: themeController.toolbarIconColor.value),
                                    hintTextStyle: regularFontStyle(size:  16,color: appTheme.dotted),
                                    hintTextAlign: TextAlign.start,
                                    padding: const EdgeInsets.only(left: 10, top: 10),
                                    hintTextPadding: const EdgeInsets.only(left: 20),
                                    backgroundColor: themeController.textfieldBgColor.value,
                                    inputAction: InputAction.newline,
                                    onEditingComplete: (s) => debugPrint('Editing completed $s'),
                                    onTextChanged: (text) => debugPrint('widget text change $text'),
                                    onEditorCreated: () {
                                      debugPrint('Editor has been loaded');
                                    },
                                    onEditorResized: (height) => debugPrint('Editor resized $height'),
                                    onSelectionChanged: (sel) => debugPrint('index ${sel.index}, range ${sel.length}'),
                                  ),
                                ),
                              ),
                            ),
                            // CommonTextFiled(hintext: "enter_description".tr,controller: controller.descController,maxLine: 21,textHeight: 1.3,),
                            SizedBox(height: height*0.04),
                            Obx(
                                  () =>  CommonPrimaryButton(text: " ${"lbl_submit".tr} ",onTap: () async {
                                if(controller.htmlResponseForSend.value.isEmpty)
                                {
                                  errorToast("Please enter description");
                                }
                                else{
                                  await controller.updateDescription();
                                  initEditor();
                                  showToast("Description updated successfully");
                                }
                              },isLoading: controller.loader.value),
                            ),
                            SizedBox(height: height*0.01),
                            // SizedBox(height: height*0.02),
                            // CommonTextFiled(hintext: "enter_description".tr,controller: controller.descController,maxLine: 21,textHeight: 1.3,),
                            // SizedBox(height: height*0.04),
                            // Obx(
                            //   () =>  CommonPrimaryButton(text: " ${"lbl_submit".tr} ",onTap: () async {
                            //     if(controller.descController.text.trim().isEmpty)
                            //       {
                            //         errorToast("Please enter description");
                            //       }
                            //     else{
                            //       await controller.updateDescription();
                            //       showToast("Description updated successfully");
                            //     }
                            //   },isLoading: controller.loader.value),
                            // ),
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


  Future<void> getHtmlText() async {
    String? htmlText = await richTextController.getText();
    log(name: "Html Text",stackTrace: StackTrace.empty,htmlText);
  }



  Future<void> initEditor() async{

    Future.delayed(Duration(seconds: 1),(){
      richTextController.setText(controller.htmlResponseForEdit.value);

      richTextController.onTextChanged((text) {
        debugPrint('listening to $text');
        controller.htmlResponseForSend.value = text;
      });
      richTextController.onEditorLoaded(() {debugPrint('Editor Loaded :)');
      });
    });

  }
}
