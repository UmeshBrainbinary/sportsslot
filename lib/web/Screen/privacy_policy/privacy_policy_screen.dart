
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/privacy_policy/privacy_policy_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:responsive_builder/responsive_builder.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:rich_editor/rich_editor.dart';
// import 'package:rich_editor/rich_editor.dart';
// import 'package:quill_html_editor/quill_editor_controller.dart';



class PrivacyPolicyScreen extends StatefulWidget {
  PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  // PrivacyPolicyController controller = Get.put(PrivacyPolicyController());
  ThemeController themeController = Get.find<ThemeController>();

  RxString htmlResponseForEdit = "".obs;
  RxString htmlResponseForSend = "".obs;
  RxBool loader = false.obs;

  @override
  void initState() {
    initEditor();
    init();

    ever(themeController.isDarkMode, (bool isDarkMode) {
      changeTheme();
    });
    super.initState();
  }

  Future<void> changeTheme() async{
    loader.value = true;
    await Future.delayed(Duration(seconds: 1),(){});
    initEditor();
    loader.value = false;
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
                            'privacyPolicy'.tr,
                            style: mediumFontStyle(size: 24),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 8),

                    Padding(
                      padding:  EdgeInsets.only(top: height*0.045,left: width*0.04,right: width*0.04),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: themeController.c.value//appTheme.white
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width*0.055,vertical: width*0.02).copyWith(bottom: width*0.013),
                        child: Column(
                          children: [
                            SizedBox(height: height*0.01),
                            Row(
                              children: [
                                Text("privacyPolicy".tr,style: regularFontStyle(size: 20),),
                                Text(" *",style: regularFontStyle(size: 21,color: appTheme.colorFF0101)),
                              ],
                            ),
                            SizedBox(height: height*0.01),

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
                                toolBarConfig: customToolBarList,
                                // customButtons: [],
                              ),
                            ),
                            SizedBox(height: height*0.02),
                            // SizedBox(height: height*0.02),
                            //
                            // CommonTextFiled(hintext: "enter_description".tr,controller: controller.privacyController,maxLine: 20,textHeight: 1.3,),
                            SizedBox(height: height*0.04),
                            Obx(
                              () =>  Container(
                                height: height*0.52,
                                color: themeController.textfieldBgColor.value,
                                child:
                                Obx(
                                      () => loader.value ? CommonLoader():  QuillHtmlEditor(
                                    text: htmlResponseForEdit.value,
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
                            SizedBox(height: height*0.02),
                            Obx(
                                  () =>  CommonPrimaryButton(text: " ${"lbl_submit".tr} ",onTap: () async {
                                if(htmlResponseForSend.value.isNotEmpty)
                                {
                                  await updatePrivacyPolicy();
                                  initEditor();
                                  showToast("Privacy policy updated successfully");
                                }
                                else{
                                  errorToast("Please enter privacy policy");
                                }

                                // if(controller.privacyController.text.trim().isEmpty)
                                // {
                                //   errorToast("Please enter privacy policy");
                                // }
                                // else{
                                // await controller.updateDescription();
                                // showToast("Privacy policy updated successfully");
                                // }
                              },isLoading: loader.value),
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

  Future<void> getHtmlText() async {
    String? htmlText = await richTextController.getText();
    log(name: "Html Text",stackTrace: StackTrace.empty,htmlText);
  }



  Future<void> init() async {
    await getPrivacyPolicy();
  }

  Future<void> getPrivacyPolicy() async {
    try {
      loader.value = true;
      DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc("privacy")
          .get();

      if (docSnapShot.data() != null) {
        Map<String, dynamic> data = docSnapShot.data() as Map<String, dynamic>;

        htmlResponseForEdit.value = data["description"];
        await initEditor();
      }
      loader.value = false;
    } catch (e) {
      log("Error fetching privacy details: $e");
      loader.value = false;
    }
  }


  Future<void> updatePrivacyPolicy() async {
    try {
      loader.value = true;
      await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc("privacy")
          .update({
        "description":htmlResponseForSend.value,
      });
      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("Error updating privacy details: $e");
    }
  }



  QuillEditorController richTextController = QuillEditorController();

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.strike,
    ToolBarStyle.size,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.align,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.undo,
    ToolBarStyle.redo
  ];


  Future<void> initEditor() async{

    Future.delayed(Duration(seconds: 1),(){
      richTextController.setText(htmlResponseForEdit.value);

      richTextController.onTextChanged((text) {
        debugPrint('listening to $text');
        htmlResponseForSend.value = text;
      });
      richTextController.onEditorLoaded(() {debugPrint('Editor Loaded :)');
      });
    });

  }
}
