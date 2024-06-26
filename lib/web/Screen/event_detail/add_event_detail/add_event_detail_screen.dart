import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/web/Common/dialog/upload_success_dialog.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/event_detail/add_event_detail/add_event_detail_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/model/event_detail_model.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_methods.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';

class AddEventDetailScreen extends StatefulWidget {
  EventDetailModel? data;
  final bool? isFromUpdate;
  AddEventDetailScreen({
    super.key,
    this.data, this.isFromUpdate
  });

  @override
  State<AddEventDetailScreen> createState() => _AddEventDetailScreenState();
}

class _AddEventDetailScreenState extends State<AddEventDetailScreen> {
  late AddEventDetailController controller;

  ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    controller = Get.put(AddEventDetailController(data: widget.data));
    if(widget.isFromUpdate == true)
      {
        controller.setDateOnEdit();
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ResponsiveBuilder(
          builder: (BuildContext context, SizingInformation sizingInformation) {
            // if (sizingInformation.isDesktop) {
            //   // width = 900;
            //   // height = 1000;
            // } else if (sizingInformation.isTablet) {
            //   // width = 550;
            //   // height = 900;
            // } else if (sizingInformation.isMobile) {
            //   // width = 350;
            // }

            return DashboardScreen(
              index: 2,
              child: Stack(
                children: [
                 Obx(() =>  Container(
                   height: height,
                   width: width,
                   color: themeController.webBgColor.value,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(
                         horizontal: 30, vertical: 30),
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(bottom: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Text(
                                 'event_Details'.tr,
                                 style: mediumFontStyle(
                                     size: 24),
                               ),
                               Spacer(),
                               GestureDetector(
                                 onTap: (){
                                   Get.back();
                                 },
                                 child: Container(
                                   height: 30,
                                   width: 30,
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     border: Border.all(color: appTheme.themeColor),
                                   ),
                                   child: Icon(Icons.close, color: appTheme.themeColor, size: 20),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Divider(height: 4),
                         SizedBox(height: Get.height * 0.01),
                         Expanded(
                           child: SingleChildScrollView(
                             child: Padding(
                               padding: EdgeInsets.symmetric(vertical: 22),
                               child: Container(
                                 width: Get.width,
                                 padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 30),
                                 decoration: BoxDecoration(
                                   color: themeController.c.value,//appTheme.white,
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                                 child: Column(
                                   children: [
                                     leftPortion(width, height,
                                         sizingInformation, context),
                                     SizedBox(height: 45),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Obx(
                                               () =>  CommonPrimaryButton(
                                             text: "${'createEvent'.tr}",
                                             isLoading: controller.loader.value,
                                             onTap: ()  async{
                                               controller.checkAllFieldValidation();
                                               if(controller.validateForm()){
                                                 if(widget.isFromUpdate == true)
                                                 {
                                                   await controller.updateEventDetails(onSuccess: (){
                                                     double dWidth = 0;
                                                     double dHeight = 0;
                                                     if (sizingInformation.isDesktop) {
                                                       dWidth = 800;
                                                       dHeight = 950;
                                                     } else if (sizingInformation.isTablet) {
                                                       dWidth = 550;
                                                       dHeight = 900;
                                                     } else if (sizingInformation.isMobile) {
                                                       dWidth = 350;
                                                     }
                                                     showUploadSuccessDialog(context: context, width: dWidth, height: dHeight, isUpdate: false,text: "eventUpdated".tr);
                                                   });
                                                 }
                                                 else{
                                                   await controller.insertEventDetails(onSuccess: (){
                                                     double dWidth = 0;
                                                     double dHeight = 0;
                                                     if (sizingInformation.isDesktop) {
                                                       dWidth = 800;
                                                       dHeight = 950;
                                                     } else if (sizingInformation.isTablet) {
                                                       dWidth = 550;
                                                       dHeight = 900;
                                                     } else if (sizingInformation.isMobile) {
                                                       dWidth = 350;
                                                     }
                                                     showUploadSuccessDialog(context: context, width: dWidth, height: dHeight, isUpdate: false,text: "eventAdded".tr);
                                                   });
                                                 }


                                               }
                                             },
                                           ),
                                         ),
                                         // SizedBox(width: 15),
                                         // CommonPrimaryButton(
                                         //   text: " ${'cancel'.tr} ",
                                         //   textColor: themeController.d.value,
                                         //   onTap: () {
                                         //     Get.back();
                                         //   },
                                         //   color: themeController.c.value,//appTheme.white,
                                         // ),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),),
                  Obx(() => controller.loader.value
                      ? Padding(
                        padding: EdgeInsets.only(right: width*0.03,bottom: height*0.02),
                        child: CommonLoader(),
                      )
                      : SizedBox()),
                ],
              ),
            );
          },
        ),
        Obx(() => controller.loader.value ? Container(
          color: Colors.transparent,
        ) : SizedBox()),
      ],
    );
  }

  Widget leftPortion(double width, double height,
      SizingInformation sizingInformation, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
        crossAxisAlignment: CrossAxisAlignment.start,

          children: [
           Column(
             children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   RichText(
                     text: TextSpan(
                       children: [
                         TextSpan(
                             text: "event_name".tr,
                             style: regularFontStyle(
                                 color: themeController.d.value,//appTheme.black,
                                 size: 18)),
                         TextSpan(
                             text: " *".tr,
                             style: regularFontStyle(
                                 color: appTheme.red700, size: 18)),
                       ],
                     ),
                     textAlign: TextAlign.left,
                   ),
                   SizedBox(width: Get.width * 0.01),
                   SizedBox(
                     width: width * 0.250,
                     child: CommonTextFiled(
                         hintext: "enterEventName".tr,
                         controller: controller.nameController),
                   ),
                 ],
               ),
               Obx(
                     () => controller.eventNameError.value.isNotEmpty
                     ? SizedBox(
                   width: width * 0.32,
                   child: Row(
                     // crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       RichText(
                         text: TextSpan(
                           children: [
                             TextSpan(
                                 text: "event_name".tr,
                                 style: regularFontStyle(
                                     color: Colors.transparent, size: 18)),
                             TextSpan(
                                 text: " *".tr,
                                 style: regularFontStyle(
                                     color: Colors.transparent, size: 18)),
                           ],
                         ),
                         textAlign: TextAlign.left,
                       ),
                       SizedBox(width: Get.width * 0.01),
                       SizedBox(
                         width: width * 0.213,
                         child: errorText(errorVar: controller.eventNameError),
                       ),
                     ],
                   ),
                 )
                     : SizedBox(),
               ),
             ],
           ),
            SizedBox(width: 30),
            Container(
              width: 0.8,
              height: 50,
              color: themeController.d.value,
            ),
            SizedBox(width: 30),
            /// entryFee
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customTitleTextWithStar(title: 'entryFee'.tr),
                    SizedBox(width: Get.width * 0.01),
                    SizedBox(
                      width: width * 0.250,
                      child: CommonTextFiled(
                        hintext: "0000",
                        controller: controller.entryFeeController,inputFormatter: [CustomInputFormatterNumberOnly()],),
                    ),
                  ],
                ),
                Obx(
                      () => controller.entryFeeError.value.isNotEmpty
                      ? SizedBox(
                    width: width * 0.32,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customTitleTextWithStar(title: 'entryFee'.tr,color: Colors.transparent),
                        SizedBox(width: Get.width * 0.01),
                        SizedBox(
                          width: width * 0.213,
                          child: errorText(errorVar: controller.entryFeeError),
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: Get.height * 0.038),


        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           Row(
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   customTitleTextWithStar(title: "start_date ".tr),
                   SizedBox(height: Get.height * 0.013),
                   GestureDetector(
                     onTap: () {
                       controller.selectStartDate(context );
                     },
                     child: Container(
                       height: 45,
                       width: width * 0.145,
                       padding: EdgeInsets.symmetric(
                           horizontal: width * 0.0075, vertical: 10),
                       decoration: BoxDecoration(
                         color: themeController.textfieldBgColor.value,//appTheme.textfieldFillColor,
                         borderRadius: BorderRadius.circular(3),
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Obx(
                                 () => Text(
                               controller.selectedStartDate.value.isEmpty
                                   ? 'DD/MM/YYYY'
                                   : controller.selectedStartDate.value,
                               style: regularFontStyle(
                                   size: 15,
                                   color: controller
                                       .selectedStartDate.value.isEmpty
                                       ? appTheme.gray600
                                       : themeController.d.value,//appTheme.black,
                                   sizingInformation: sizingInformation),
                             ),
                           ),
                           Image.asset(AssetRes.calendarIcon, color: appTheme.themeColor,),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(width: width * 0.022),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   customTitleTextWithStar(title: "end_date".tr),
                   SizedBox(height: Get.height * 0.013),
                   GestureDetector(
                     onTap: () {
                       controller.selectEndDate(context);
                     },
                     child: Container(
                       height: 45,
                       width: width * 0.145,
                       padding: EdgeInsets.symmetric(
                           horizontal: width * 0.0075, vertical: 10),
                       decoration: BoxDecoration(
                         color: themeController.textfieldBgColor.value,//appTheme.textfieldFillColor,
                         borderRadius: BorderRadius.circular(3),
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Obx(
                                 () => Text(
                               controller.selectedEndDate.value.isEmpty
                                   ? 'DD/MM/YYYY'
                                   : controller.selectedEndDate.value,
                               style: regularFontStyle(
                                   size: 15,
                                   color:
                                   controller.selectedEndDate.value.isEmpty
                                       ? appTheme.gray600
                                       : themeController.d.value,//appTheme.black,
                                   sizingInformation: sizingInformation),
                             ),
                           ),
                           Image.asset(AssetRes.calendarIcon, color: appTheme.themeColor),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ],
           ),
          SizedBox(width: 80),
            Column(
              children: [
                SizedBox(
                  width: width * 0.31,
                  child: Row(
                    children: [
                      customTitleText(title: "${'timing'.tr} : "),
                      SizedBox(width: width * 0.011),
                      SizedBox(
                        width: width * 0.1,
                        child: CommonTextFiled(
                          hintext: 'lbl_select_time'.tr,
                          controller: controller.fromTimeController,
                          readOnly: true,
                          onTap: () {
                            controller.timePicker(context: context, type: 0);
                          },
                        ),
                      ),
                      customTitleText(title: "  ${'to'.tr}  "),
                      SizedBox(
                        width: width * 0.1,
                        child: CommonTextFiled(
                          hintext: 'lbl_select_time'.tr,
                          controller: controller.toTimeController,
                          readOnly: true,
                          onTap: () {
                            controller.timePicker(context: context, type: 1);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () =>controller.timeError.value.isEmpty ?
                  SizedBox() :Row(
                    children: [
                      errorText(errorVar: controller.timeError),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Obx(
          () =>controller.dateError.value.isEmpty ?
          SizedBox() : Row(
            children: [
              errorText(errorVar: controller.dateError),
            ],
          ),
        ),


        SizedBox(height: height * 0.053),

        ///description
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTitleTextWithStar(title: 'description'.tr),
              SizedBox(height: height * 0.013),
              SizedBox(
                width: width * 0.33,
                height: height * 0.18,
                child: CommonTextFiled(
                    hintext: "enter_description".tr,
                    controller: controller.descriptionController,
                    maxLine: 5,
                    hintHeight: 2,
                    textHeight: 1.2),
              ),
              errorText(errorVar: controller.descriptionError),
            ],
          ),
          SizedBox(width: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTitleTextWithStar(title: 'locationUrl'.tr),
              SizedBox(height: height * 0.013),
              SizedBox(

    width: width * 0.30,

                child: CommonTextFiled(
                    hintext: "enterLocationUrl".tr,
                    controller: controller.urlController),
              ),
              Obx(() => controller.urlError.value.isNotEmpty ? SizedBox(
                width: width * 0.32,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customTitleTextWithStar(
                        title: 'locationUrl'.tr,color: Colors.transparent),
                    SizedBox(width: Get.width * 0.01),
                    errorText(errorVar: controller.urlError),
                  ],
                ),
              ) : SizedBox()),
            ],
          )
        ],
      ),

        SizedBox(height: height * 0.03),



        /// add image
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "addEventImage".tr,
                  style: regularFontStyle(
                      color: themeController.d.value,//appTheme.black,
                      size: 18)),
              TextSpan(
                  text: " *".tr,
                  style: regularFontStyle(
                      color: appTheme.red700, size: 18)),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: height * 0.02),
        Row(
          children: [
            Container(
              width: width * 0.04,

              child: Column(
                children: [
                  DottedBorder(
                    borderType: BorderType.Rect,
                    borderPadding:
                    EdgeInsets.symmetric(
                        horizontal: 3),
                    padding:
                    EdgeInsets.symmetric(
                        horizontal: 3),
                    radius: Radius.circular(15),
                    color: appTheme.dotted,
                    dashPattern: [10, 6],
                    strokeWidth: 1,
                    child: InkWell(
                      onTap: () async{

                        List<String> images = await pickMultiImage();
                        controller.eventImgList.value.addAll(images);
                        controller.eventImgList.value = controller.eventImgList.value.toSet().toList();
                        controller.eventImgList.refresh();

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
                  ),
                ],
              ),
            ),
            SizedBox(width: 30),
            Obx(
                  () => controller.eventImgList.value.isNotEmpty
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                child: SizedBox(
                  height: sizingInformation.isDesktop ? 70 : 50,
                  width: width * 0.32,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.eventImgList.value.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                          width: sizingInformation.isDesktop ? 8 : 6);
                    },
                    itemBuilder: (context, index) {
                      final data = controller.eventImgList.value[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(data,
                                height:
                                sizingInformation.isDesktop ? 70 : 50,
                                width:
                                sizingInformation.isDesktop ? 70 : 50,
                                fit: BoxFit.fill),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  controller.eventImgList.value
                                      .removeAt(index);
                                  controller.eventImgList.refresh();
                                },
                                child: Container(
                                  height: 14,
                                  width: 14,
                                  margin: EdgeInsets.only(top: 4, right: 5),
                                  padding: EdgeInsets.all(2),
                                  color: Colors.white,
                                  child: Image.asset(AssetRes.deleteIcon),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
                  : controller.eventImgError.value.isNotEmpty
                  ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(controller.eventImgError.value,
                    style: errorTextStyle()),
              )
                  : SizedBox(),
            ),
          ],
        ),

        SizedBox(height: height * 0.04),

        /// previousMemory
        customTitleTextWithStar(
            title: 'previousMemory'.tr),
        SizedBox(height: height * 0.02),
        Row(
          children: [
            Container(
              width: width * 0.04,

              child: Column(
                children: [
                  DottedBorder(
                    borderType: BorderType.Rect,
                    borderPadding:
                    EdgeInsets.symmetric(
                        horizontal: 3),
                    padding:
                    EdgeInsets.symmetric(
                        horizontal: 3),
                    radius: Radius.circular(15),
                    color: appTheme.dotted,
                    dashPattern: [10, 6],
                    strokeWidth: 1,
                    child: InkWell(
                      onTap: () async{
                        List<String> images = await pickMultiImage();
                        controller.preMemoryImgList.value.addAll(images);
                        controller.preMemoryImgList.value = controller.preMemoryImgList.value.toSet().toList();
                        controller.preMemoryImgList.refresh();

                        // controller
                        //     .update(["add"]);
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
                  ),
                ],
              ),
            ),
            SizedBox(width: 30),
            Obx(() => SizedBox(height:controller
                .preMemoryImgList.value.isNotEmpty ? height * 0.02 : 0)),
            Obx(
                  () => controller.preMemoryImgList.value.isNotEmpty
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                child: SizedBox(
                  height: sizingInformation.isDesktop ? 70 : 50,
                  width: width * 0.32,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.preMemoryImgList.value.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                          width: sizingInformation.isDesktop ? 8 : 6);
                    },
                    itemBuilder: (context, index) {
                      final data = controller.preMemoryImgList.value[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.network(data,
                                height:
                                sizingInformation.isDesktop ? 70 : 50,
                                width:
                                sizingInformation.isDesktop ? 70 : 50,
                                fit: BoxFit.fill),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  controller.preMemoryImgList.value
                                      .removeAt(index);
                                  controller.preMemoryImgList.refresh();
                                },
                                child: Container(
                                  height: 14,
                                  width: 14,
                                  margin: EdgeInsets.only(top: 4, right: 5),
                                  padding: EdgeInsets.all(2),
                                  color: Colors.white,
                                  child: Image.asset(AssetRes.deleteIcon),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
                  : controller.preMemoryImgList.value.isNotEmpty
                  ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(controller.preMemoryImgError.value,
                    style: errorTextStyle()),
              )
                  : SizedBox(),
            ),
          ],
        ),




      ],
    );
  }

  Widget customTitleTextWithStar({required String title,Color? color}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: regularFontStyle(color:color ?? themeController.d.value,//appTheme.black,
                  size: 18)),
          TextSpan(
              text: " *".tr,
              style: regularFontStyle(color:color ?? appTheme.red700, size: 18)),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget customTitleText({required String title}) {
    return Text(title,
        style: regularFontStyle(color: themeController.d.value,//appTheme.black,
            size: 18));
  }

  Widget errorText({required RxString errorVar}) {
    return Obx(
      () => errorVar.value.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(errorVar.value, style: errorTextStyle()),
            )
          : SizedBox(),
    );
  }
}
