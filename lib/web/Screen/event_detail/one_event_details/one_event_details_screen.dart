import 'package:flutter/material.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';
import 'package:sportsslot/web/Screen/event_detail/one_event_details/one_event_details_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/model/event_detail_model.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_export.dart';

class OneEventDetailScreen extends StatelessWidget {
  final EventDetailModel data;
  OneEventDetailScreen({super.key, required this.data});

  final OneEventDetailController controller =
      Get.put(OneEventDetailController());

  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        if (sizingInformation.isDesktop) {
          width = 800;
          height = 1000;
        } else if (sizingInformation.isTablet) {
          width = 550;
          height = 900;
        } else if (sizingInformation.isMobile) {
          width = 350;
        }

        return DashboardScreen(
          index: 2,
          child: Obx(() => Container(
            color: themeController.webBgColor.value,//appTheme.secondarybgcolor,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'event_Details'.tr,
                          style: boldFontStyle(
                              color: appTheme.themeColor, size: 24),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: Get.height * 0.01),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 50, horizontal: Get.width * 0.035),
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: themeController.c.value,//appTheme.white,
                            borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: appTheme.themeColor)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.02, vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.03),
                                Container(
                                  height: height*0.28,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(data.eventImages.first),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.03),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                            data.name,
                                            style: mediumFontStyle(
                                              size: 26,
                                              color: themeController.d.value,//appTheme.black
                                            ))),
                                    // Text("₹${data.price.toStringAsFixed(2)}",
                                    //     style: boldFontStyle(
                                    //         size: 26,
                                    //         color: appTheme.themeColor)),
                                  ],
                                ),
                                SizedBox(height: height * 0.025),
                                Text(
                                    data.description,
                                    style: regularFontStyle(
                                      size: 17, color: themeController.d.value,//appTheme.black
                                    )),
                                SizedBox(height: height * 0.025),
                                (data.url ?? "").isNotEmpty ?  Row(
                                  children: [
                                    Text("Location: ",style: mediumFontStyle(size: 17, color: themeController.d.value//appTheme.black
                                    )),
                                    SizedBox(width: width*0.02),
                                    TextButton(onPressed: () async{
                                      await urlOpen(data.url ?? "");
                                    }, child: Text(data.url ?? "",style: regularFontStyle(size: 17,color: appTheme.blueIcon),),),
                                  ],
                                ) : SizedBox(),
                                // Row(
                                //   children: [
                                //     CircleAvatar(
                                //       radius: 28,
                                //       backgroundImage:
                                //           AssetImage(AssetRes.mainGround),
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                // Column(
                                //   crossAxisAlignment:
                                //       CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       'Main Ground',
                                //       style: mediumFontStyle(
                                //           size: 20, color: appTheme.black),
                                //     ),
                                //     SizedBox(height: 3),
                                //     Text('5 Min, l venenatis',
                                //         style: regularFontStyle(
                                //             size: 14,
                                //             color: appTheme.dotted)),
                                //   ],
                                // )
                                //   ],
                                // ),
                                (data.url ?? "").isNotEmpty ? SizedBox(height: height * 0.022) : SizedBox(height: 4),
                                Container(
                                  width: width*0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: themeController.bgColor.value,//appTheme.textfieldFillColor,
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal:width*0.03,vertical: width*0.02),
                                    child: Column(
                                      children: [
                                        descRow(title: 'last_day_of_registration'.tr,text: DateFormat("dd MMM yyyy").format(data.endDate),),
                                        SizedBox(height: 12),
                                        descRow(title: 'entry_fee'.tr,text: '₹ ${data.price.toStringAsFixed(2)}'),
                                        SizedBox(height: 12),
                                        descRow(title: 'tournament start'.tr,text:DateFormat("dd MMM yyyy").format(data.startDate),),
                                        SizedBox(height: 12),
                                        descRow(title:'time'.tr,text:data.fromTime != null || data.toTime != null ?'${DateFormat("hh:mm a").format(data.fromTime!)} - ${DateFormat("hh:mm a").format(data.toTime!)}':"-"),
                                      ],
                                    ),
                                  ),


                                ),
                                SizedBox(height: height * 0.028),
                                Text("previous_memory".tr,
                                    style: mediumFontStyle(
                                        size: 26, color: themeController.d.value//appTheme.black
                                    )),
                                SizedBox(height: height * 0.015),
                                GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: data.preMemoryImages.length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: Get.width * 0.02,
                                      mainAxisSpacing: 15,
                                      mainAxisExtent:sizingInformation.isDesktop ? 190 : 140),
                                  itemBuilder: (_, index) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: appTheme.textfieldFillColor,
                                    ),
                                    child: Container(
                                      height:sizingInformation.isDesktop ? 140 : 100,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(data.preMemoryImages[index]),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
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
          )),
        );
      },
    );
  }
  Future<void> urlOpen(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Widget descRow({required String title,required String text}) {
    return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(title,
                                          style: regularFontStyle(
                                              size: 16,
                                              color: appTheme.dotted)),
                                      Text(text,
                                          style: regularFontStyle(
                                              size: 16, color: themeController.d.value//appTheme.black
                                          )),

                                    ],
                                  );
  }
}
