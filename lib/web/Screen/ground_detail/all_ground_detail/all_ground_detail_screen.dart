import 'package:flutter/material.dart';
import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/Common_edit_delet_pop.dart';
import 'package:sportsslot/web/Common/commmon_add_button.dart';
import 'package:sportsslot/web/Common/dialog/delete_success_dialog.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';
import 'package:sportsslot/web/Screen/ground_detail/add_ground_detail/add_ground_detail_controller.dart';
import 'package:sportsslot/web/Screen/ground_detail/add_ground_detail/add_ground_detail_screen.dart';
import 'package:sportsslot/web/Screen/ground_detail/all_ground_detail/all_ground_detail_controller.dart';
import 'package:sportsslot/web/Screen/ground_detail/one_ground_detail/one_ground_detail_screen.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AllGroundDetailScreen extends StatelessWidget {
  AllGroundDetailScreen({super.key});

  final AllGroundDetailController controller = Get.put(AllGroundDetailController());
  final AddGroundDetailController addGroundController = Get.put(AddGroundDetailController());
  ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return

      DashboardScreen(
      index: 3,
      child: ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizingInformation) {
          if (sizingInformation.isDesktop) {
            // width = 800;
            // height = 1000;
          } else if (sizingInformation.isTablet) {
            // width = 550;
            // height = 900;
          } else if (sizingInformation.isMobile) {
            // width = 350;
          }

          return Obx(
            () =>  Container(
              color: themeController.webBgColor.value,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ground_details'.tr,
                                style:  mediumFontStyle(
                                    size: 24//boldFontStyle(color: appTheme.black, size: 24
                                ) ,
                              ),
                              // CustomAddButton(text: 'add_ground_details'.tr,
                              //     onTap: () {    addGroundController.clearData();
                              // Get.to(
                              //   transition: Transition.noTransition,
                              //       () => AddGroundDetailScreen(),
                              // ); }
                              // ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {    addGroundController.clearData();
                                Get.to(
                                  transition: Transition.noTransition,
                                      () => AddGroundDetailScreen(),
                                ); },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: appTheme.themeColor),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: appTheme.themeColor,
                                    size: 17,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Divider(),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:  EdgeInsets.only(top: height*0.06,left: width*0.022,right: width*0.01),
                              child: Obx(
                                    () =>
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        spacing: width * 0.02,
                                        runSpacing: width * 0.02,
                                        children: controller.groundDetailList.value.asMap().entries.map((item) {
                                          int index = item.key;
                                          return MouseRegion(
                                            onEnter: (_) {
                                              controller.isHover[index] = true;
                                            },
                                            onExit: (_) {
                                              controller.isHover[index] = false;
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(transition: Transition.noTransition, () => OneGroundDetailScreen(data:controller.groundDetailList.value[index]));
                                              },
                                              child: Obx(
                                                    () => Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 300,
                                                    // maxHeight: 240,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: themeController.c.value, // appTheme.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    border: Border.all(color: appTheme.themeColor),
                                                    boxShadow: controller.isHover.value[index]
                                                        ? [BoxShadow(color: Color(0xFF000000).withOpacity(0.08), offset: Offset(0, 16), blurRadius: 20, spreadRadius: 0)]
                                                        : null,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 8),
                                                        Row(
                                                          //mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              controller.groundDetailList.value[index].mainGround?.name ?? "",
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: boldFontStyle(size: 20, color: themeController.d.value//appTheme.black
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Obx(
                                                                  () =>controller.loader.value
                                                                      ? Image(
                                                                  width: 20,
                                                                  height: 20,
                                                                  image: AssetImage(AssetRes.dot)):  CommonEditDeletePopup(
                                                                editArgs: "stadium",
                                                                onTapEdit: () {
                                                                  if(controller.loader.value)
                                                                  {

                                                                  }
                                                                  else{
                                                                    addGroundController.setDataOnInit(data: controller.groundDetailList.value[index]);
                                                                    Get.to(
                                                                      transition: Transition.noTransition,
                                                                          () => AddGroundDetailScreen(isFromUpdate: true,data: controller.groundDetailList.value[index]),
                                                                    );
                                                                  }

                                                                },
                                                                onTapDelete: () {
                                                                  if(controller.loader.value)
                                                                  {

                                                                  }
                                                                  else{
                                                                    print("delete");
                                                                    showDeleteSuccessDialog(context: context, width: 800, height: 800, onTap: () { Navigator.pop(context);
                                                                    controller.deleteGroundByName(data: controller.groundDetailList.value[index],onSuccess: (){});
                                                                    },isLoading: controller.loader, msg: 'deleteGround'.tr);
                                                                  }

                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),



                                                        SizedBox(height: 20),
                                                        Container(
                                                          height: 118,
                                                          width: Get.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            image: DecorationImage(image: NetworkImage(controller.groundDetailList.value[index].mainGround?.image?.first ?? ""), fit: BoxFit.cover),
                                                          ),
                                                        ),
                                                        SizedBox(height: 13),
                                                      ],
                                                    ),
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

                        // Expanded(
                        //   child: GridView.builder(
                        //     padding: EdgeInsets.all(30),
                        //     physics: BouncingScrollPhysics(),
                        //     itemCount: controller.data.length,
                        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 10, mainAxisExtent: 250),
                        //     itemBuilder: (_, index) => MouseRegion(
                        //       onEnter: (_) {
                        //         controller.isHover[index] = true;
                        //       },
                        //       onExit: (_) {
                        //         controller.isHover[index] = false;
                        //       },
                        //       child: Obx(() => Padding(
                        //           padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               Get.to(
                        //                   transition: Transition.noTransition,
                        //                       () => OneGroundDetailScreen());
                        //             },
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 color: appTheme.white,
                        //                 borderRadius: BorderRadius.all(Radius.circular(15)),
                        //                 boxShadow: controller.isHover.value[index]
                        //                     ? [
                        //                         BoxShadow(
                        //                           color: Color(0xFF000000).withOpacity(0.08),
                        //                           offset: Offset(0, 16),
                        //                           blurRadius: 20,
                        //                           spreadRadius: 0,
                        //                         ),
                        //                 ]
                        //                     : null,
                        //               ),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.symmetric(horizontal: 20),
                        //                 child: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: [
                        //                     Row(
                        //                       mainAxisAlignment: MainAxisAlignment.end,
                        //                       children: [
                        //                         Common_edit_pop(
                        //                           onTapEdit: () {
                        //                             print("edit");
                        //                           },
                        //                           onTapDelete: () {
                        //                             print("delete");
                        //                           },
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     Container(
                        //                       height: 115,
                        //                       width: Get.width,
                        //                       decoration: BoxDecoration(
                        //                         borderRadius: BorderRadius.circular(10),
                        //                         image: DecorationImage(image: AssetImage(controller.data[index]["image"]),fit: BoxFit.cover)
                        //                       ),
                        //                     ),
                        //
                        //                     SizedBox(height: 20),
                        //                     Text(
                        //                       controller.data[index]["title"],
                        //                       style: boldFontStyle(size: 20, color: appTheme.black),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
    );
  }
}
