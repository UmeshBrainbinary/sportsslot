import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/Common_edit_delet_pop.dart';
import 'package:sportsslot/web/Common/commmon_add_button.dart';
import 'package:sportsslot/web/Common/dialog/delete_success_dialog.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';
import 'package:sportsslot/web/Screen/event_detail/add_event_detail/add_event_detail_screen.dart';
import 'package:sportsslot/web/Screen/event_detail/all_event_detail/all_event_detail_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../one_event_details/one_event_details_screen.dart';

class AllEventDetailScreen extends StatelessWidget {
  AllEventDetailScreen({super.key});
  final AllEventDetailController controller = Get.put(AllEventDetailController());
  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    controller.isHover.value =
        List.generate(controller.data.length, (index) => false);
    return DashboardScreen(
      index: 2,
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
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'event_Details'.tr,
                                style:  mediumFontStyle(size: 24),
                                //boldFontStyle(color: appTheme.black, size: 24),
                              ),

                              CustomAddButton(text: 'add_Event_Details'.tr, onTap: () {
                                Get.to(
                                  transition: Transition.noTransition,
                                      () => AddEventDetailScreen(),
                                ); }),
                            ],
                          ),
                        ),
                        Divider(),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.055,
                                  bottom: height * 0.02,
                                  left: width * 0.017),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Obx(
                                      () =>
                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        spacing: width * 0.02,
                                        runSpacing: width * 0.02,
                                        children: controller.eventList.value
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
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                    transition: Transition.noTransition,
                                                        () => OneEventDetailScreen(data: controller.eventList.value[index]));
                                              },
                                              child: Obx(
                                                    () => Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: 300,
                                                    // maxHeight: 240,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: themeController.c.value,//appTheme.white,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(15)),
                                                    boxShadow: controller
                                                        .isHover.value[index]
                                                        ? [
                                                      BoxShadow(
                                                          color: Color(0xFF000000)
                                                              .withOpacity(0.08),
                                                          offset: Offset(0, 16),
                                                          blurRadius: 20,
                                                          spreadRadius: 0)
                                                    ]
                                                        : null,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                          children: [
                                                            Obx(
                                                                  () =>controller.loader.value ?Image(
                                                                  width: 20,
                                                                  height: 20,
                                                                  image: AssetImage(AssetRes.dot)) :  CommonEditDeletePopup(
                                                                editArgs: "event detail",
                                                                onTapEdit: () {
                                                                  if(controller.loader.value)
                                                                  {

                                                                  }
                                                                  else{
                                                                    Get.to(()=> AddEventDetailScreen(isFromUpdate: true,data: controller.eventList.value[index]),transition: Transition.noTransition);
                                                                  }
                                                                  // AddEventDetailScreen
                                                                },
                                                                onTapDelete: () {

                                                                  if(controller.loader.value)
                                                                  {

                                                                  }
                                                                  else{
                                                                    print("delete");
                                                                    showDeleteSuccessDialog(
                                                                        context: context,
                                                                        width: 800,
                                                                        height: 800,
                                                                        onTap: () async {

                                                                          Navigator.pop(context);
                                                                          await controller.deleteEventData(
                                                                              data: controller.eventList.value[index], onSuccess: () {});


                                                                        },
                                                                        isLoading: controller.loader, msg: 'deleteEvent'.tr);
                                                                  }

                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 118,
                                                          width: Get.width,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    controller
                                                                        .eventList
                                                                        .value[index]
                                                                        .eventImages
                                                                        .first),
                                                                fit: BoxFit.cover),
                                                          ),
                                                        ),
                                                        SizedBox(height: 12),
                                                        Text(
                                                          controller.eventList
                                                              .value[index].name,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: boldFontStyle(
                                                              size: 20,
                                                              color: themeController.d.value//appTheme.black
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          'Start date ${DateFormat("dd MMMM").format(controller.eventList.value[index].startDate)}',
                                                          style: mediumFontStyle(
                                                              color: appTheme.gray600,size: 14),
                                                        ),
                                                        SizedBox(height: 11),
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
