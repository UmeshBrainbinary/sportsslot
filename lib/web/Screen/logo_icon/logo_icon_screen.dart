import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/web/Common/Common_edit_delet_pop.dart';
import 'package:sportsslot/web/Common/commmon_add_button.dart';
import 'package:sportsslot/web/Common/dialog/delete_success_dialog.dart';
import 'package:sportsslot/web/Common/dialog/edit_dialog.dart';
import 'package:sportsslot/web/Common/dialog/insert_dialog.dart';
import 'package:sportsslot/web/Common/dialog/upload_success_dialog.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/logo_icon/logo_icon_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LogoIconScreen extends StatelessWidget {
  LogoIconScreen({super.key});
  LogoIconController controller = Get.put(LogoIconController());
ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ResponsiveBuilder(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'sportIcon'.tr,
                                  style: mediumFontStyle(
                                      size: 24),
                                ),
                                CustomAddButton(
                                    text: "uploadSportIcon".tr,
                                    onTap: () {
                                    controller.imagePath.value = "";
                                    controller.nameController.clear();
                                    showInsertDialog(
                                        context: context,
                                        width: width,
                                        height: height,

                                        imageUrl: controller.imagePath,
                                        textController: controller.nameController,
                                        onTap: () async {

                                          await controller.uploadSportIcon(
                                            base64Images: [controller.imagePath.value],
                                            onSuccess: () {

                                              showUploadSuccessDialog(
                                                  context: context,
                                                  width: width,
                                                  height: height,
                                                  isUpdate: false);

                                            }, context: context,
                                          );
                                        },
                                        isLoading: controller.loader);
                                  }
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 8,color: themeController.dividerColor.value),

                          SizedBox(height: height*0.014),

                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.045,
                                    bottom: height * 0.02,
                                    left: width * 0.05),
                                child: Obx(
                                  () =>
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Wrap(
                                                alignment: WrapAlignment.start,
                                                spacing: width * 0.04,
                                                runSpacing: width * 0.04,
                                                children: controller.sportIconList.value
                                                    .asMap()
                                                    .entries
                                                    .map((item) {
                                                  int index = item.key;
                                                  return MouseRegion(
                                                    onEnter: (_) {
                                                      controller.isHover[index] = true;
                                                    },
                                                    onExit: (_) {
                                                      controller.isHover[index] = false;
                                                    },
                                                    child: Obx(
                                                      () => Container(
                                                        constraints: BoxConstraints(
                                                            maxWidth: sizingInformation
                                                                    .isDesktop
                                                                ? width * 0.3
                                                                : width * 0.42,
                                                            maxHeight: sizingInformation
                                                                    .isDesktop
                                                                ? width * 0.3
                                                                : width * 0.42),
                                                        decoration: BoxDecoration(
                                                          color: themeController.c.value,//appTheme.white,
                                                          borderRadius: BorderRadius.all(
                                                            Radius.circular(15),
                                                          ),
                                                          boxShadow: controller
                                                                  .isHover.value[index]
                                                              ? [
                                                                  BoxShadow(
                                                                    color:
                                                                        Color(0xFF000000)
                                                                            .withOpacity(
                                                                                0.08),
                                                                    offset: Offset(0, 16),
                                                                    blurRadius: 20,
                                                                    spreadRadius: 0,
                                                                  ),
                                                                ]
                                                              : null,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 20,
                                                              top: 5,
                                                              right: 20,
                                                              bottom: 14),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.end,
                                                                children: [
                                                                   Obx(
                                                                     () => controller.loader.value ?Image(
                                                                         width: 20,
                                                                         height: 20,
                                                                         image: AssetImage(AssetRes.dot)):
                                                                     CommonEditDeletePopup(
                                                                        onTapEdit: () {
                                                                       if(controller.loader.value)
                                                                         {}
                                                                       else{
                                                                         controller.imagePath
                                                                             .value = "";
                                                                         controller
                                                                             .nameController
                                                                             .text =
                                                                             controller
                                                                                 .sportIconList
                                                                                 .value[
                                                                             index]
                                                                                 .name;

                                                                         showEditDialog(
                                                                             context:
                                                                             context,
                                                                             width: width,
                                                                             height: height,
                                                                             image: controller
                                                                                 .sportIconList
                                                                                 .value[
                                                                             index]
                                                                                 .image,
                                                                             imageUrl:
                                                                             controller
                                                                                 .imagePath,
                                                                             textController:
                                                                             controller
                                                                                 .nameController,
                                                                             onTap:
                                                                                 () async {

                                                                               await controller
                                                                                   .updateSportIcon(
                                                                                 base64Images: [
                                                                                   controller
                                                                                       .sportIconList
                                                                                       .value[
                                                                                   index]
                                                                                       .image
                                                                                 ],
                                                                                 isFromUpdate:
                                                                                 true,
                                                                                 id: controller
                                                                                     .sportIconList
                                                                                     .value[
                                                                                 index]
                                                                                     .id ?? "",
                                                                                 onSuccess:
                                                                                     () {

                                                                                   showUploadSuccessDialog(
                                                                                       context:
                                                                                       context,
                                                                                       width:
                                                                                       width,
                                                                                       height:
                                                                                       height,
                                                                                       isUpdate:
                                                                                       true);
                                                                                 }, context: context,
                                                                               );
                                                                             },
                                                                             isLoading:
                                                                             controller
                                                                                 .loader);
                                                                       }
                                                                        },
                                                                        onTapDelete: () {
                                                                         if(controller.loader.value)
                                                                           {}
                                                                         else{
                                                                           showDeleteSuccessDialog(
                                                                               context:
                                                                               context,
                                                                               width: width,
                                                                               height: height,
                                                                               onTap:
                                                                                   () async {
                                                                                 Navigator.pop(context);
                                                                                 await controller
                                                                                     .deleteSportIconByName(
                                                                                     id: controller.sportIconList.value[index].id ?? "",
                                                                                     onSuccess:
                                                                                         () {},
                                                                                     url: controller.sportIconList.value[index].image);
                                                                               },
                                                                               isLoading:
                                                                               controller
                                                                                   .loader);
                                                                         }
                                                                        },
                                                                        editArgs:
                                                                            "sportIcon".tr,
                                                                      ),
                                                                   ),

                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                        top: 5,
                                                                        bottom: 30),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(4),
                                                                  child: Image.network(
                                                                      controller.sportIconList.value[index].image,
                                                                      height: 105,
                                                                      width: 105,
                                                                      fit: BoxFit.fill),
                                                                ),
                                                              ),
                                                              Text(
                                                                controller.sportIconList
                                                                    .value[index].name,
                                                                style: TextStyle(
                                                                    fontSize: 19.5,
                                                                    fontWeight:
                                                                        FontWeight.bold,
                                                                    color:
                                                                    themeController.d.value
                                                                        //appTheme.black
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(() =>
                      controller.loader.value ?
                      CommonLoader() : SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Obx(() => controller.loader.value ?
            Container(
              color: Colors.transparent,
            ):SizedBox()
        ),
      ],
    );
  }
}


