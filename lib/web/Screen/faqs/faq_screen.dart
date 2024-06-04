import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/commmon_add_button.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Screen/faqs/faq_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});
  FaqController controller = Get.put(FaqController());
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'faqs'.tr,
                          style: mediumFontStyle(size: 24),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 8),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.045,
                          left: width * 0.04,
                          right: width * 0.04,
                          bottom: height * 0.015),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: themeController.c.value//appTheme.white
                        ),
                        padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04, vertical: width * 0.02)
                            .copyWith(bottom: width * 0.013),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "faqs".tr,
                                      style: regularFontStyle(size: 21),
                                    ),
                                    Text(" *",
                                        style: regularFontStyle(
                                            size: 21,
                                            color: appTheme.colorFF0101)),
                                  ],
                                ),
                                CustomAddButton(
                                  text: "addQuestion".tr,
                                  onTap: () {
                                    controller.questionController.value.add(TextEditingController());
                                    controller.answerController.value.add(TextEditingController());
                                    controller.questionController.refresh();
                                    controller.answerController.refresh();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Expanded(
                              child: Obx(
                                () =>  ListView.separated(
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.questionController.value.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: height * 0.03);
                                  },
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text((index+1).toString(),style: mediumFontStyle(size: 17,sizingInformation: sizingInformation),),
                                            SizedBox(width: width*0.02),
                                            Expanded(
                                              child: CommonTextFiled(
                                                  hintext: "enterQue".tr,
                                                  controller: controller
                                                      .questionController[index],
                                                  maxLine: 1,
                                                  textHeight: 0.9),
                                            ),
                                            Obx(() => controller.questionController.value.length > 1 ? SizedBox(width: width*0.015) : SizedBox()),
                                            Obx(
                                              () =>  controller.questionController.value.length > 1 ?
                                              GestureDetector(
                                                onTap:(){
                                                  controller.showDeleteConfirmationDialog(context: context, index: index);
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 25,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 3),
                                                      child: Image.asset(AssetRes.deleteIcon),
                                                    ),),
                                              ) : SizedBox(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.015),
                                        Row(
                                          children: [
                                            Text((index+1).toString(),style: mediumFontStyle(size: 17,sizingInformation: sizingInformation,color: Colors.transparent),),
                                            SizedBox(width: width*0.02),
                                            Expanded(
                                              child: CommonTextFiled(
                                                  hintext: "enterAns".tr,
                                                  controller:
                                                      controller.answerController[index],
                                                  maxLine: 4,
                                                  textHeight: 1.3),
                                            ),
                                            Obx(() => controller.questionController.value.length > 1 ? SizedBox(width: width*0.015) : SizedBox()),
                                            Obx(
                                                  () =>  controller.questionController.value.length > 1 ?
                                              GestureDetector(
                                                onTap:(){
                                                  // controller.showDeleteConfirmationDialog(context: context, index: index);
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 25,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: 3),
                                                    child: Image.asset(AssetRes.deleteIcon,color: Colors.transparent),
                                                  ),),
                                              ) : SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.025),
                            Obx(
                              () => CommonPrimaryButton(
                                  text: " ${"lbl_submit".tr} ",
                                  onTap: () async {
                                if(controller.validateQuestionAns())
                                  {

                                    await controller.updateFaqs();
                                  }
                                else{
                                  errorToast("Please fill all question and answer");
                                }
                                  },
                                  isLoading: controller.loader.value),
                            ),
                            SizedBox(height: height * 0.01),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
