import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/Common/CommonTextfile.dart';
import 'package:sportsslot/web/Common/common_methods.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Common/dialog/upload_success_dialog.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';
import 'package:sportsslot/web/Screen/ground_detail/add_ground_detail/add_ground_detail_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddGroundDetailScreen extends StatefulWidget {
  GroundDetailModel? data;
  final bool? isFromUpdate;
  AddGroundDetailScreen({super.key,this.data, this.isFromUpdate});

  @override
  State<AddGroundDetailScreen> createState() => _AddGroundDetailScreenState();
}

class _AddGroundDetailScreenState extends State<AddGroundDetailScreen> {
  AddGroundDetailController controller = Get.find<AddGroundDetailController>();
  ScrollController stadiumScrollController = ScrollController();
  ScrollController featureScrollController = ScrollController();
  ScrollController subGroundScrollController = ScrollController();
  ThemeController themeController = Get.find<ThemeController>();


@override
  void initState() {
    controller.init();
    controller.isShiftUpdating.value = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<AddGroundDetailController>(
      id: "add",
      builder: (AddGroundDetailController controller) {
      return Stack(

        children: [
          ResponsiveBuilder(
            builder: (BuildContext context, SizingInformation sizingInformation) {
              if (sizingInformation.isDesktop) {
                // width = 900;
                // height = 1000;
              } else if (sizingInformation.isTablet) {
                // width = 550;
                // height = 900;
              } else if (sizingInformation.isMobile) {
                // width = 350;
              }

              return DashboardScreen(
                index: 1,
                child: Stack(
                  children: [
                    Obx(() =>  Container(
                      height: height,
                      width: width,
                      color: themeController.webBgColor.value, //appTheme.secondarybgcolor,

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
                                    widget.isFromUpdate ==true ? "ground_details_edit".tr:   'ground_details'.tr,
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
                            Divider(),
                            SizedBox(height: Get.height * 0.01),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  child: Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color:  themeController.bgColor.value,//appTheme.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 30),
                                      child: Column(
                                        children: [

                                          ///
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.32,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 80,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 15),
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                          "categories"
                                                                              .tr,
                                                                          style: regularFontStyle(
                                                                              color: themeController.d.value,//appTheme.black,
                                                                              size:
                                                                              18)),
                                                                      TextSpan(
                                                                          text:
                                                                          " *".tr,
                                                                          style: regularFontStyle(
                                                                              color: appTheme
                                                                                  .red700,
                                                                              size:
                                                                              18)),
                                                                    ],
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: Get.width * 0.01),
                                                        Expanded(
                                                          child: Container(
                                                            height: 80,
                                                            alignment: Alignment.bottomCenter,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 50,
                                                                  child: Obx(
                                                                        () => controller.loader.value ? SizedBox():
                                                                    MultiSelectDropDown(
                                                                      fieldBackgroundColor: themeController.textfieldBgColor.value,
                                                                      dropdownBackgroundColor: themeController.textfieldBgColor.value,
                                                                      optionsBackgroundColor: themeController.textfieldBgColor.value,
                                                                      selectedOptions: controller.selectedCategoryValueItem,
                                                                      hint: 'select_categories'.tr,
                                                                      hintStyle:
                                                                      regularFontStyle(
                                                                        color: appTheme.dotted,
                                                                        size: 16,
                                                                      ),
                                                                      onOptionSelected:
                                                                          (List<ValueItem>
                                                                      selectedOptions) async {
                                                                        if (selectedOptions
                                                                            .isNotEmpty) {
                                                                          controller
                                                                              .selectedCategory
                                                                              .clear();
                                                                          print(controller
                                                                              .selectedCategory);
                                                                          for (ValueItem selectedItem
                                                                          in selectedOptions) {
                                                                            controller
                                                                                .selectedCategory
                                                                                .add(selectedItem
                                                                                .label);
                                                                          }
                                                                        } else {
                                                                          controller
                                                                              .selectedCategory
                                                                              .clear();
                                                                        }
                                                                        print(controller
                                                                            .selectedCategory);
                                                                        controller
                                                                            .update([
                                                                          "add"
                                                                        ]);
                                                                      },
                                                                      options: [
                                                                        ...controller
                                                                            .category
                                                                            .value,
                                                                        // ...controller.logoIconController.sportIconList.map((sportIcon) =>
                                                                        //     ValueItem(label: sportIcon.name, value: sportIcon.name)),
                                                                      ],
                                                                      borderColor:
                                                                      appTheme
                                                                          .dotted,
                                                                      borderRadius: 5,
                                                                      borderWidth: 1,
                                                                      selectionType:
                                                                      SelectionType
                                                                          .multi,
                                                                      chipConfig:
                                                                      ChipConfig(
                                                                        radius: 5,
                                                                        backgroundColor: appTheme.themeColor,

                                                                        wrapType:
                                                                        WrapType
                                                                            .scroll,
                                                                      ),
                                                                      dropdownHeight:
                                                                      250,
                                                                      showChipInSingleSelectMode:
                                                                      true,

                                                                      selectedOptionBackgroundColor: themeController.textfieldBgColor.value,//appTheme.colorE6F0FD,
                                                                      selectedOptionTextColor: themeController.d.value,//appThem.black,
                                                                      optionTextStyle:
                                                                      const TextStyle(
                                                                        fontFamily:
                                                                        'FontRegular',
                                                                        fontSize: 15,
                                                                      ),
                                                                      selectedOptionIcon: Icon(Icons.check_circle, color: themeController.d.value,),
                                                                    ),
                                                                  ),
                                                                ),
                                                                controller
                                                                    .categoryError
                                                                    .isNotEmpty
                                                                    ? Text(
                                                                  controller
                                                                      .categoryError,
                                                                  style: controller
                                                                      .errorTextStyle(),
                                                                )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(height: Get.height * 0.03),

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
                                                                  controller.mainGroundImageList.value.addAll(images);
                                                                  controller.mainGroundImageList.value = controller.mainGroundImageList.value.toSet().toList();
                                                                  controller.mainGroundImageList.refresh();
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
                                                            () => controller.mainGroundImageList.value.isNotEmpty
                                                            ? Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                                                          child: SizedBox(
                                                            height: sizingInformation.isDesktop ? 70 : 50,
                                                            width: width * 0.32,
                                                            child: ListView.separated(
                                                              shrinkWrap: true,
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount: controller.mainGroundImageList.value.length,
                                                              separatorBuilder: (context, index) {
                                                                return SizedBox(
                                                                    width: sizingInformation.isDesktop ? 8 : 6);
                                                              },
                                                              itemBuilder: (context, index) {
                                                                final data = controller.mainGroundImageList.value[index];
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
                                                                            controller.mainGroundImageList.value
                                                                                .removeAt(index);
                                                                            controller.mainGroundImageList.refresh();
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
                                                            : controller.groundImgError.value.isNotEmpty
                                                            ? Padding(
                                                          padding: const EdgeInsets.only(top: 10),
                                                          child: Text(controller.groundImgError.value,
                                                              style: errorTextStyle()),
                                                        )
                                                            : SizedBox(),
                                                      ),
                                                    ],
                                                  ),




                                                  SizedBox(height: Get.height * 0.04),

                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: "stadium_name".tr,
                                                            style: regularFontStyle(
                                                                color: themeController.d.value,//appTheme.black,
                                                                size: 18)),
                                                        TextSpan(
                                                            text: " *".tr,
                                                            style: regularFontStyle(
                                                                color:
                                                                appTheme.red700,
                                                                size: 18)),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(
                                                      height: Get.height * 0.015),
                                                  SizedBox(
                                                    width: width * 0.32,
                                                    child: CommonTextFiled(
                                                        hintext:
                                                        "enter_stadium_name".tr,
                                                        controller: controller
                                                            .groundNameController),
                                                  ),
                                                  controller
                                                      .groundNameError.isNotEmpty
                                                      ? Text(
                                                      controller.groundNameError,
                                                      style: controller
                                                          .errorTextStyle())
                                                      : SizedBox(),

                                                  SizedBox(height: Get.height * 0.04),

                                                  /// Location
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: "location".tr,
                                                            style: regularFontStyle(
                                                                color:  themeController.d.value,//appTheme.black,
                                                                size: 18)),
                                                        TextSpan(
                                                            text: " *".tr,
                                                            style: regularFontStyle(
                                                                color:
                                                                appTheme.red700,
                                                                size: 18)),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),

                                                  SizedBox(
                                                      height: Get.height * 0.015),

                                                  SizedBox(
                                                    width: width * 0.32,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: CommonTextFiled(
                                                                hintext:
                                                                "latitude".tr,
                                                                inputFormatter: [
                                                                  CustomInputFormatterNumberOnly()
                                                                ],
                                                                controller: controller
                                                                    .latitudeController)),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'And'.tr,
                                                          style: regularFontStyle(
                                                              color: themeController.d.value,//appTheme.black,
                                                              size: 14),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                            child: CommonTextFiled(
                                                                inputFormatter: [
                                                                  CustomInputFormatterNumberOnly()
                                                                ],
                                                                hintext:
                                                                "longitude".tr,
                                                                controller: controller
                                                                    .longitudeController)),
                                                      ],
                                                    ),
                                                  ),
                                                  controller.locationError.isNotEmpty
                                                      ? Text(controller.locationError,
                                                      style: controller
                                                          .errorTextStyle())
                                                      : SizedBox(),

                                                  /// tagLine
                                                  SizedBox(height: Get.height * 0.04),

                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: "taglines".tr,
                                                            style: regularFontStyle(
                                                                color:  themeController.d.value,//appTheme.black,
                                                                size: 18)),
                                                        TextSpan(
                                                            text: " *".tr,
                                                            style: regularFontStyle(
                                                                color:
                                                                appTheme.red700,
                                                                size: 18)),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(
                                                      height: Get.height * 0.015),

                                                  SizedBox(
                                                    width: width * 0.32,
                                                    child: CommonTextFiled(
                                                        hintext:
                                                        "enter_your_taglines".tr,
                                                        controller: controller
                                                            .taglineController),
                                                  ),
                                                  controller.taglineError.isNotEmpty
                                                      ? Text(controller.taglineError,
                                                      style: controller
                                                          .errorTextStyle())
                                                      : SizedBox(),


                                                  SizedBox(height: Get.height * 0.04),
                                                  ///feature
                                                  SizedBox(
                                                    width: width * 0.32,
                                                    child: Row(
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: "features".tr,
                                                                  style: regularFontStyle(
                                                                      color: themeController.d.value,//appTheme.black,
                                                                      size: 18)),
                                                              TextSpan(
                                                                  text: " *".tr,
                                                                  style: regularFontStyle(
                                                                      color: appTheme
                                                                          .red700,
                                                                      size: 18)),
                                                            ],
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                        // SizedBox(width: 8),
                                                        // Expanded(
                                                        //   flex: 2,
                                                        //   child: InkWell(
                                                        //     onTap: () {
                                                        //       pickImage(controller
                                                        //           .featuresIcon);
                                                        //       controller.update(["add"]);
                                                        //     },
                                                        //     child: Obx(
                                                        //       () => Container(
                                                        //         height: 45,
                                                        //         decoration: BoxDecoration(
                                                        //             color: appTheme
                                                        //                 .webBgColor,
                                                        //             borderRadius:
                                                        //                 BorderRadiusDirectional
                                                        //                     .circular(
                                                        //                         10)),
                                                        //         child: controller
                                                        //                 .featuresIcon
                                                        //                 .isEmpty
                                                        //             ? Row(
                                                        //                 mainAxisAlignment:
                                                        //                     MainAxisAlignment
                                                        //                         .spaceEvenly,
                                                        //                 children: [
                                                        //                   Image.asset(
                                                        //                       AssetRes
                                                        //                           .addImageIcon,
                                                        //                       scale: 4),
                                                        //                   Text("add_icon"
                                                        //                       .tr),
                                                        //                 ],
                                                        //               )
                                                        //             : Image.network(
                                                        //                 controller
                                                        //                     .featuresIcon
                                                        //                     .value),
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                            flex: 4,
                                                            child: CommonTextFiled(
                                                                hintext:
                                                                "enter_features"
                                                                    .tr,
                                                                controller: controller
                                                                    .featureController)),
                                                        SizedBox(width: 10),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await controller.featuresValidation();
                                                          },
                                                          child: Obx(
                                                                () =>  Container(
                                                              height: 40,
                                                              width: 40,
                                                              alignment:
                                                              Alignment.center,
                                                              decoration: BoxDecoration(
                                                                  color: themeController.textfieldBgColor.value,//appTheme.webBgColor,
                                                                  borderRadius:
                                                                  BorderRadiusDirectional
                                                                      .circular(
                                                                      10)),
                                                              child: Icon(Icons.add,
                                                                  color: appTheme
                                                                      .themeColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  controller.featureError.isNotEmpty
                                                      ? Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 90),
                                                    child: Text(
                                                        controller.featureError,
                                                        style: controller
                                                            .errorTextStyle()),
                                                  )
                                                      : SizedBox(),
                                                  Obx(
                                                        () =>
                                                    controller.featuresList.value
                                                        .isNotEmpty
                                                        ? Container(
                                                      constraints:
                                                      BoxConstraints(
                                                          maxHeight:
                                                          170),
                                                      width: width * 0.32,
                                                      child: Scrollbar(
                                                        controller:
                                                        featureScrollController,
                                                        child: ListView
                                                            .separated(
                                                          controller:
                                                          featureScrollController,
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets.only(
                                                              top: height *
                                                                  0.02,
                                                              bottom:
                                                              height *
                                                                  0.01),
                                                          itemCount: controller
                                                              .featuresList
                                                              .value
                                                              .length,
                                                          separatorBuilder:
                                                              (context,
                                                              index) {
                                                            return SizedBox(
                                                                height:
                                                                height *
                                                                    0.01);
                                                          },
                                                          itemBuilder:
                                                              (context,
                                                              index) {
                                                            final data = controller
                                                                .featuresList
                                                                .value[index];
                                                            return Row(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .min,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Obx(
                                                                      () =>  Container(
                                                                    // width: width * 0.2,
                                                                    // height: 45,
                                                                    constraints:
                                                                    BoxConstraints(
                                                                        maxWidth: width * 0.18),
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: width *
                                                                            0.009,
                                                                        vertical:
                                                                        height * 0.011),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(
                                                                            10),
                                                                        color:
                                                                        themeController.textfieldBgColor.value),
                                                                    child: Center(
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width:
                                                                              width * 0.16,
                                                                              child:
                                                                              Text(
                                                                                data.name,
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: regularFontStyle(size: 16, sizingInformation: sizingInformation),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                    10),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () {
                                                                    controller
                                                                        .featuresList
                                                                        .value
                                                                        .removeAt(index);
                                                                    controller
                                                                        .featuresList
                                                                        .refresh();
                                                                  },
                                                                  child:
                                                                  Obx(
                                                                        () =>  Container(
                                                                      height: height *
                                                                          0.0325,
                                                                      width: height *
                                                                          0.0325,
                                                                      padding:
                                                                      EdgeInsets.all(4),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius.circular(7),
                                                                          color:themeController.deleteBgColor.value),
                                                                      child: Image
                                                                          .asset(
                                                                        AssetRes
                                                                            .deleteIcon,
                                                                        height:
                                                                        15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                        : SizedBox(),
                                                  ),

                                                ],
                                              ),

                                              /// add sub ground
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [

                                                  /// add sub ground
                                                  Container(
                                                    width: width * 0.32,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(15),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: appTheme.dotted),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(15),
                                                      child: Column(
                                                        children: [
                                                          DottedBorder(
                                                            borderType:
                                                            BorderType.Rect,
                                                            borderPadding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 3),
                                                            padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 3),
                                                            radius:
                                                            Radius.circular(15),
                                                            color: appTheme.dotted,
                                                            dashPattern: [10, 6],
                                                            strokeWidth: 1,
                                                            child: InkWell(
                                                              onTap: () async{
                                                                List<String> images = await pickMultiImage();
                                                                controller.subGroundImageList.value.addAll(images);
                                                                controller.subGroundImageList.value = controller.subGroundImageList.value.toSet().toList();
                                                                controller.subGroundImageList.refresh();
                                                                // pickMultiImage(controller.subGroundImageList);
                                                                controller.update(["add"]);
                                                              },
                                                              child: Container(
                                                                  height: 100,
                                                                  width: Get.width,
                                                                  child:
                                                                  // widget.isFromUpdate == true  && controller.selectedSubGImg.isNotEmpty?
                                                                  // Stack(
                                                                  //   children: [
                                                                  //     controller
                                                                  //         .selectedSubGImg.value
                                                                  //         .isEmpty ? Center(
                                                                  //           child: Row(
                                                                  //             mainAxisAlignment: MainAxisAlignment.center,
                                                                  //             crossAxisAlignment:
                                                                  //             CrossAxisAlignment.center,
                                                                  //             children: [
                                                                  //           Image.asset(
                                                                  //               AssetRes
                                                                  //                   .addImageIcon,
                                                                  //               scale:
                                                                  //               4),
                                                                  //           SizedBox(
                                                                  //               width:
                                                                  //               5),
                                                                  //           Text("add_ground_image"
                                                                  //               .tr),],
                                                                  //                                                                           ),
                                                                  //         ) : Center(
                                                                  //       child:
                                                                  //       SizedBox(
                                                                  //         height:
                                                                  //         90,
                                                                  //         width: 90,
                                                                  //         child:
                                                                  //         Stack(
                                                                  //           children: [
                                                                  //             ClipRRect(
                                                                  //               borderRadius:
                                                                  //               BorderRadius.circular(3),
                                                                  //               child: Image.network(controller.selectedSubGImg.value[0],
                                                                  //                   fit: BoxFit.fill,
                                                                  //                   height: 90,
                                                                  //                   width: 90),
                                                                  //             ),
                                                                  //             Positioned(
                                                                  //               top:
                                                                  //               1,
                                                                  //               right:
                                                                  //               1,
                                                                  //               child:
                                                                  //               GestureDetector(
                                                                  //                 onTap: () {
                                                                  //                   controller.selectedSubGImg.value[0] ="";
                                                                  //                   controller.selectedSubGImg.refresh();
                                                                  //                 },
                                                                  //                 child: Container(
                                                                  //                   height: 16,
                                                                  //                   width: 16,
                                                                  //                   margin: EdgeInsets.only(top: 4, right: 5),
                                                                  //                   padding: EdgeInsets.all(2),
                                                                  //                   color: Colors.white,
                                                                  //                   child: Image.asset(AssetRes.deleteIcon),
                                                                  //                 ),
                                                                  //               ),
                                                                  //             ),
                                                                  //           ],
                                                                  //         ),
                                                                  //       ),
                                                                  //     ),
                                                                  //     Align(
                                                                  //       alignment: Alignment.topRight,
                                                                  //       child: Container(
                                                                  //         height: width*0.015,
                                                                  //         width: width*0.015,
                                                                  //         margin: EdgeInsets.only(top: 6, right: 6),
                                                                  //         decoration: BoxDecoration(
                                                                  //           borderRadius: BorderRadius.circular(3),
                                                                  //           border: Border.all(width: 0.5,color: appTheme.colorB3B3BF),
                                                                  //           image: DecorationImage(image: NetworkImage(controller.selectedSubGImg.value[0]),fit: BoxFit.fill),
                                                                  //         ),
                                                                  //         child: Image.network(controller.selectedSubGImg.value[0]),
                                                                  //       ),
                                                                  //     ),
                                                                  //   ],
                                                                  // ):
                                                                  //
                                                                  //     controller.selectedSubGImg.value.isEmpty
                                                                  //     ?
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      Image.asset(
                                                                          AssetRes
                                                                              .addImageIcon,
                                                                          scale:
                                                                          4, color: appTheme.themeColor
                                                                      ),
                                                                      SizedBox(width: 5),
                                                                      Text("add_ground_image"
                                                                          .tr),
                                                                    ],
                                                                  )


                                                                //  : Center(
                                                                //   child:
                                                                //   SizedBox(
                                                                //     height:
                                                                //     90,
                                                                //     width: 90,
                                                                //     child: Stack(
                                                                //       children: [
                                                                //         ClipRRect(
                                                                //           borderRadius:
                                                                //           BorderRadius.circular(3),
                                                                //           child: Image.network(controller.selectedSubGImg.value[0],
                                                                //               fit: BoxFit.fill,
                                                                //               height: 90,
                                                                //               width: 90),
                                                                //         ),
                                                                //         Positioned(
                                                                //           top: 1,
                                                                //           right: 1,
                                                                //           child:
                                                                //           GestureDetector(
                                                                //             onTap: () {
                                                                //               controller.selectedSubGImg.value[0] = "";
                                                                //               controller.selectedSubGImg.refresh();
                                                                //             },
                                                                //             child: Container(
                                                                //               height: 16,
                                                                //               width: 16,
                                                                //               margin: EdgeInsets.only(top: 4, right: 5),
                                                                //               padding: EdgeInsets.all(2),
                                                                //               color: Colors.white,
                                                                //               child: Image.asset(AssetRes.deleteIcon),
                                                                //             ),
                                                                //           ),
                                                                //         ),
                                                                //       ],
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ),

                                                            ),
                                                          ),
                                                          Obx(
                                                                () =>
                                                            controller.subGroundImageList
                                                                .value.isNotEmpty
                                                                ? Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 3,
                                                                  vertical: 12),
                                                              child: SizedBox(
                                                                height:
                                                                sizingInformation
                                                                    .isDesktop
                                                                    ? 70
                                                                    : 50,
                                                                width: width * 0.32,
                                                                child: Scrollbar(
                                                                  controller:subGroundScrollController,
                                                                  child: ListView.separated(
                                                                    shrinkWrap: true,
                                                                    controller:subGroundScrollController,
                                                                    scrollDirection: Axis.horizontal,
                                                                    itemCount: controller.subGroundImageList.value.length,
                                                                    separatorBuilder: (context, index) {
                                                                      return SizedBox(
                                                                          width: sizingInformation
                                                                              .isDesktop
                                                                              ? 8
                                                                              : 6);
                                                                    },
                                                                    itemBuilder:
                                                                        (context,
                                                                        index) {
                                                                      final data =
                                                                      controller
                                                                          .subGroundImageList
                                                                          .value[index];
                                                                      return ClipRRect(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                        child:
                                                                        Stack(
                                                                          alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                          children: [
                                                                            Image.network(
                                                                                data,
                                                                                height: sizingInformation.isDesktop
                                                                                    ? 70
                                                                                    : 50,
                                                                                width: sizingInformation.isDesktop
                                                                                    ? 70
                                                                                    : 50,
                                                                                fit:
                                                                                BoxFit.fill),
                                                                            Align(
                                                                              alignment:
                                                                              Alignment.topRight,
                                                                              child:
                                                                              GestureDetector(
                                                                                onTap:
                                                                                    () {
                                                                                  controller.subGroundImageList.value.removeAt(index);
                                                                                  controller.subGroundImageList.refresh();
                                                                                },
                                                                                child:
                                                                                Container(
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
                                                              ),
                                                            )

                                                                :SizedBox(),
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "${"ground_name".tr} : ",
                                                                  style: regularFontStyle(
                                                                      size: 18,
                                                                      sizingInformation:
                                                                      sizingInformation)),
                                                              SizedBox(width: 15),
                                                              SizedBox(
                                                                width: width * 0.13,
                                                                child: CommonTextFiled(
                                                                    hintext:
                                                                    "enter_ground_name"
                                                                        .tr,
                                                                    controller: controller
                                                                        .subGroundName),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "${"duration".tr} : ",
                                                                  style: regularFontStyle(
                                                                      size: 18,
                                                                      sizingInformation:
                                                                      sizingInformation)),
                                                              SizedBox(width: 15),

                                                              Container(
                                                                  width: width * 0.08,
                                                                  padding: EdgeInsets.only(right: 14),
                                                                  decoration: BoxDecoration(
                                                                      color: themeController.textfieldBgColor.value,//appTheme.textfieldFillColor,
                                                                      borderRadius: BorderRadius.circular(10)
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                          child:CommonTextFiled(
                                                                            inputFormatter: [
                                                                              CustomInputFormatterNumberOnly()
                                                                            ],
                                                                            hintext:
                                                                            "0hour".tr,
                                                                            controller: controller
                                                                                .durationController,keyboardType:
                                                                          TextInputType
                                                                              .number,contentPadding: EdgeInsets.only(left: width*0.008,right: 3),)


                                                                      ),
                                                                      Text(" Hour ",style:  regularFontStyle(size:15,color: themeController.d.value,//appTheme.black,
                                                                          height: 0.8),),
                                                                    ],
                                                                  )),

                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          SizedBox(
                                                            width: width * 0.32,
                                                            child: Row(
                                                              children: [
                                                                RichText(
                                                                  text: TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          text: "price".tr,
                                                                          style: regularFontStyle(
                                                                              color: themeController.d.value,//appTheme.black,
                                                                              size: 18)),
                                                                      TextSpan(
                                                                          text: " *".tr,
                                                                          style: regularFontStyle(
                                                                              color: appTheme
                                                                                  .red700,
                                                                              size: 18)),
                                                                    ],
                                                                  ),
                                                                  textAlign: TextAlign.left,
                                                                ),
                                                                SizedBox(width: 20),
                                                                Container(
                                                                    width: width * 0.08,
                                                                    padding: EdgeInsets.only(right: 14),
                                                                    decoration: BoxDecoration(
                                                                        color: themeController.textfieldBgColor.value,//appTheme.textfieldFillColor,
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: CommonTextFiled(
                                                                            inputFormatter: [
                                                                              CustomInputFormatterNumberOnly()
                                                                            ],
                                                                            hintext:
                                                                            "enter_price".tr,
                                                                            controller: controller
                                                                                .priceController,
                                                                            keyboardType:
                                                                            TextInputType
                                                                                .number,contentPadding: EdgeInsets.only(left: width*0.008,right: 3),),
                                                                        ),
                                                                        Text(" / ",style:  regularFontStyle(size:18,color: themeController.d.value,//appTheme.black,
                                                                            height: 0.8),),
                                                                        Text("( Per hour )",style:  regularFontStyle(size:10,color: themeController.d.value,//appTheme.black,
                                                                            height: 0.8),),
                                                                      ],
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "${"timing".tr} : ",
                                                                  style: regularFontStyle(
                                                                      size: 18,
                                                                      sizingInformation:
                                                                      sizingInformation)),
                                                              SizedBox(
                                                                  width:
                                                                  width * 0.01),
                                                              Container(
                                                                constraints:
                                                                BoxConstraints(
                                                                    maxHeight:
                                                                    150),
                                                                width: width * 0.23,
                                                                child: Obx(
                                                                      () => ListView.separated(
                                                                    shrinkWrap: true,
                                                                    separatorBuilder:
                                                                        (context,
                                                                        index) {
                                                                      return SizedBox(
                                                                          height: 7);
                                                                    },
                                                                    itemCount: controller
                                                                        .fromTimePickerControllerList
                                                                        .value
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                        index) {
                                                                      return Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: width *
                                                                                0.077,
                                                                            child:
                                                                            CommonTextFiled(
                                                                              hintext:
                                                                              "0hour".tr,
                                                                              controller: controller
                                                                                  .fromTimePickerControllerList
                                                                                  .value[index],
                                                                              readOnly:
                                                                              true,
                                                                              onTap:
                                                                                  () {
                                                                                controller.timePicker(
                                                                                    context: context,
                                                                                    type: 0,
                                                                                    index: index);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.symmetric(
                                                                                horizontal:
                                                                                width * 0.01),
                                                                            child: Text(
                                                                                "to",
                                                                                style: regularFontStyle(
                                                                                    size: 18,
                                                                                    sizingInformation: sizingInformation)),
                                                                          ),
                                                                          SizedBox(
                                                                            width: width *
                                                                                0.077,
                                                                            child:
                                                                            CommonTextFiled(
                                                                              hintext: "0hour".tr,
                                                                              controller: controller.toTimePickerControllerList.value[index],
                                                                              readOnly:
                                                                              true,
                                                                              onTap:
                                                                                  () {
                                                                                controller.timePicker(
                                                                                    context: context,
                                                                                    type: 1,
                                                                                    index: index);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: width *
                                                                                  0.006),
                                                                          index ==
                                                                              (controller.fromTimePickerControllerList.value.length -
                                                                                  1)
                                                                              ? GestureDetector(
                                                                            onTap:
                                                                                () async {

                                                                              controller.fromTimePickerControllerList.value.add(TextEditingController());
                                                                              controller.toTimePickerControllerList.value.add(TextEditingController());
                                                                              controller.fromTimePickerControllerList.refresh();
                                                                              controller.toTimePickerControllerList.refresh();
                                                                            },
                                                                            child:
                                                                            Container(
                                                                              height: 30,
                                                                              width: 30,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: themeController.textfieldBgColor.value,//appTheme.webBgColor
                                                                              ),
                                                                              child: Icon(Icons.add, color: appTheme.themeColor),
                                                                            ),
                                                                          )
                                                                              : SizedBox(),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          CommonPrimaryButton(
                                                            text: 'save'.tr,
                                                            onTap: () async {

                                                              await controller.subGroundValidation(subGrounds: widget.data?.subGrounds);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  controller.subGroundError.isNotEmpty
                                                      ? Text(
                                                      controller.subGroundError,
                                                      style: controller
                                                          .errorTextStyle())
                                                      : SizedBox(),
                                                  SizedBox(height: height*0.01),
                                                  Obx(
                                                        () =>
                                                    controller.subGroundsList.value
                                                        .isNotEmpty
                                                        ? Container(
                                                      constraints:
                                                      BoxConstraints(maxHeight: 280),
                                                      width: width * 0.32,
                                                      child: Scrollbar(
                                                        child: ListView.separated(
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets.only(
                                                              top: height * 0.015,
                                                              bottom:height * 0.01),
                                                          itemCount: controller.subGroundsList.value.length,
                                                          separatorBuilder:
                                                              (context,
                                                              index) {
                                                            return SizedBox(
                                                                height:
                                                                height * 0.01);
                                                          },
                                                          itemBuilder:
                                                              (context, index2) {
                                                            final data = controller.subGroundsList.value[index2];
                                                            return GestureDetector(
                                                              onTap: (){
                                                                controller.isShiftUpdating.value = true;
                                                                controller.selectedSubGroundIndex = index2;
                                                                // controller.selectedSubGImg.value = data.images ??[];
                                                                // controller.singleGroundImageUrl.value = "";
                                                                // controller.selectedSubGImg.clear();
                                                                controller.subGroundName.text = data.name ??"";
                                                                controller.priceController.text = data.price.toStringAsFixed(2);
                                                                controller.durationController.text = data.duration.toStringAsFixed(2);
                                                                controller.subGroundImageList.assignAll(data.image ??[]);
                                                                controller.fromTimePickerControllerList.value = List.generate(data.timeShifts?.length ?? 1, (i) => TextEditingController(text: DateFormat("hh:mm a").format(data.timeShifts![i].from!)));
                                                                controller.toTimePickerControllerList.value = List.generate(data.timeShifts?.length ?? 1, (i) => TextEditingController(text: DateFormat("hh:mm a").format(data.timeShifts![i].to!)));
                                                                controller.fromTimePickerControllerList.refresh();
                                                                controller.toTimePickerControllerList.refresh();
                                                                controller.subGroundImageList.refresh();
                                                              },
                                                              child: Container(
                                                                color: Colors.transparent,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  children: [
                                                                    SizedBox(
                                                                        width: width * 0.007),
                                                                    Obx(
                                                                      () =>  Container(
                                                                        // width: width * 0.2,
                                                                        // height: 45,
                                                                        constraints:
                                                                        BoxConstraints(
                                                                            maxWidth: width * 0.25),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: width *
                                                                                0.007,
                                                                            vertical:
                                                                            width * 0.007),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(
                                                                                10),
                                                                            color:themeController.isDarkMode.value ?
                                                                            Color(0xFF212121):
                                                                            appTheme.textfieldFillColor),
                                                                        child: Center(
                                                                            child: Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height:
                                                                                  width * 0.032,
                                                                                  width:
                                                                                  width * 0.07,
                                                                                  child:
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(6),
                                                                                    child: Image.network(data.image != null ? data.image!.first : "", fit: BoxFit.fill),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                    width: width * 0.005),
                                                                                SizedBox(
                                                                                  height: height*0.077,
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceAround,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [

                                                                                      SizedBox(
                                                                                        width: width * 0.15,
                                                                                        child: Text(
                                                                                          data.name ?? "",
                                                                                          maxLines: 2,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: regularFontStyle(size: 17, sizingInformation: sizingInformation),
                                                                                        ),
                                                                                      ),
                                                                                      // SizedBox(height: height*0.003),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: width * 0.08,
                                                                                            child: Text(
                                                                                              "Duration: ${data.duration ?? " "} Hr",
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: regularFontStyle(size: 14, sizingInformation: sizingInformation, color: appTheme.color554E56),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: width * 0.08,
                                                                                            child: Text(
                                                                                              "Price: ₹${data.price ?? " "}/Hr",
                                                                                              maxLines: 1,
                                                                                              textAlign: TextAlign.end,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: regularFontStyle(size: 14, sizingInformation: sizingInformation, color: appTheme.color554E56),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),


                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    SizedBox(width: 10),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .subGroundsList
                                                                            .value
                                                                            .removeAt(index2);
                                                                        controller
                                                                            .subGroundsList
                                                                            .refresh();
                                                                      },
                                                                      child:
                                                                      Obx(
                                                                        () =>  Container(
                                                                          height: height *
                                                                              0.0325,
                                                                          width: height *
                                                                              0.0325,
                                                                          padding:
                                                                          EdgeInsets.all(4),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius:
                                                                              BorderRadius.circular(7),
                                                                              color: themeController.deleteBgColor.value),
                                                                          child: Image
                                                                              .asset(
                                                                            AssetRes
                                                                                .deleteIcon,
                                                                            height:
                                                                            15,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                        : SizedBox(),
                                                  ),


                                                    /// description
                                                  SizedBox(height: Get.height * 0.04),

                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: "description".tr,
                                                            style: regularFontStyle(
                                                                color:  themeController.d.value,//appTheme.black,
                                                                size: 18)),
                                                        TextSpan(
                                                            text: " *".tr,
                                                            style: regularFontStyle(
                                                                color:
                                                                appTheme.red700,
                                                                size: 18)),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(
                                                      height: Get.height * 0.015),

                                                  SizedBox(
                                                    width: width * 0.32,
                                                    height: height * 0.18,
                                                    child: CommonTextFiled(
                                                        hintext:
                                                        "enter_description".tr,
                                                        controller: controller
                                                            .descriptionController,
                                                        maxLine: 5,
                                                        hintHeight: 2,textHeight: 1.2),
                                                  ),
                                                  controller.descriptionError.isNotEmpty
                                                      ? Text(
                                                      controller.descriptionError,
                                                      style: controller
                                                          .errorTextStyle())
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 45),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Obx(
                                                    () =>  CommonPrimaryButton(
                                                  text: "${'createStadium'.tr}",
                                                  isLoading: controller.loader.value,
                                                  onTap: () async {
                                                    await controller.categoryValidation();
                                                    await controller.groundImageValidation();
                                                    await controller.groundNameValidation();
                                                    await controller.locationValidation();
                                                    await controller.taglineValidation();
                                                    await controller.descriptionValidation();
                                                    await controller.emptyFeatureValidation();
                                                    await controller.emptySubGroundValidation();


                                                    // await controller.priceValidation();

                                                    if (controller.categoryError.isEmpty &&
                                                        controller.groundImgError.value.isEmpty &&
                                                        controller.groundNameError.isEmpty &&
                                                        controller.locationError.isEmpty &&
                                                        controller.taglineError.isEmpty &&
                                                        controller.descriptionError.isEmpty) {
                                                      if (controller.featuresList.value.isEmpty) {
                                                        controller.featureError = 'Please enter at-least one feature';
                                                      } else if (controller.subGroundsList.value.isEmpty) {
                                                        controller.subGroundError = 'Please enter at-least one sub ground';
                                                      } else {
                                                        print("validation done");
                                                        if(widget.isFromUpdate == true) {
                                                          await  controller.updateGroundDetails(
                                                            onSuccess: () {
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
                                                              showUploadSuccessDialog(context: context, width: dWidth, height: dHeight, isUpdate: false,text: "groundUpdated".tr);
                                                              // showToast(
                                                              //     "Ground detail uploaded");
                                                              setState(() {

                                                              });
                                                            }, stadiumData: widget.data ?? GroundDetailModel(timestamp: DateTime.now()),
                                                          );

                                                        }
                                                        else {
                                                          await   controller.insertGroundDetails(
                                                            onSuccess: () {
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
                                                              showUploadSuccessDialog(context: context, width: dWidth, height: dHeight, isUpdate: false,text:"groundAdded".tr);
                                                              // showToast(
                                                              //     "Ground detail uploaded");
                                                              setState(() {

                                                              });
                                                            },
                                                          );

                                                        }

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
                                              //   color: themeController.c.value,
                                              //   //appTheme.white,
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
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
                        ? CommonLoader()
                        : SizedBox()),
                  ],
                ),
              );
            },
          ),
          Obx(
                () => controller.loader.value == true ?
            Container(
              color: Colors.transparent,
            ) : SizedBox(),
          )
        ],
      );
      },

    );
  }
}
