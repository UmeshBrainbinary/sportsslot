import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';
import 'package:sportsslot/web/Screen/ground_detail/one_ground_detail/one_ground_detail_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class OneGroundDetailScreen extends StatelessWidget {
  final  GroundDetailModel data;
  OneGroundDetailScreen({super.key,required this.data});

  final OneGroundDetailController controller = Get.put(OneGroundDetailController());
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
          index: 1,
          child: Obx(() => Container(
            color: themeController.webBgColor.value,//appTheme.secondarybgcolor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'ground_details'.tr,
                          style: boldFontStyle(color: appTheme.themeColor, size: 24),
                        ),
                      ],
                    ),
                  ),
                  Divider(),

                  SizedBox(height: Get.height * 0.01),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50,horizontal: Get.width * 0.035),
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: themeController.c.value,//appTheme.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: appTheme.themeColor)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02,vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.02),

                                Container(
                                  height: height*0.28,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(data.mainGround!.image!.first),fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                SizedBox(height: height * 0.03),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(data.mainGround?.name ?? "",style:  mediumFontStyle(size: 26,color:  themeController.d.value//appTheme.black
                                    ))),
                                    Text("₹${data.subGrounds?.first.price.toStringAsFixed(2)}",style:  boldFontStyle(size: 26,color: appTheme.themeColor
                                    )),
                                  ],
                                ),

                                SizedBox(height: height * 0.01),
                                Text(data.mainGround?.tagline ?? "",style:  mediumFontStyle(size: 20,color:  themeController.d.value//appTheme.black
                                )),
                                SizedBox(height: height * 0.025),
                                Text(data.mainGround?.description ?? "",style:  regularFontStyle(size: 17,color:  themeController.d.value
                                  //appTheme.black
                                )),
                                SizedBox(height: height * 0.025),
                                Text("facilities".tr,style: mediumFontStyle(size: 26,color:  themeController.d.value//appTheme.black
                                )),
                                SizedBox(height: height * 0.02),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  direction: Axis.horizontal,
                                  spacing: width * 0.04,
                                  runSpacing: width * 0.017,
                                  children: (data.features ?? []).map((item) {
                                    // int index = item.;
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(height: 16,width: 16,decoration: BoxDecoration(color: appTheme.themeColor,shape: BoxShape.circle),),
                                        SizedBox(width: width*0.01),
                                        Text(item.name ?? "",style: regularFontStyle(size: 17),),
                                      ],
                                    );

                                  }).toList(),
                                ),
                                // GridView.builder(
                                //   primary: false,
                                //   shrinkWrap: true,
                                //   itemCount: data.features?.length ?? 0,
                                //   gridDelegate:
                                //   SliverGridDelegateWithFixedCrossAxisCount(
                                //       mainAxisExtent: 120,
                                //       crossAxisCount: sizingInformation.isDesktop? 5 : 4,
                                //       mainAxisSpacing: 20,
                                //       crossAxisSpacing: 30),
                                //   itemBuilder: (context, index) {
                                //     return Container(
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: appTheme.textfieldFillColor,
                                //       ),
                                //       child: Padding(
                                //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                //         child: Column(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           children: [
                                //             Container(
                                //               height: 60,
                                //               width: 60,
                                //               alignment: Alignment.center,
                                //               decoration: BoxDecoration(
                                //                 image: DecorationImage(
                                //                   scale: 5,
                                //                   image: AssetImage(controller.facility[0]["image"]),
                                //                 ),
                                //                 shape: BoxShape.circle, color: appTheme.whiteA700,
                                //               ),
                                //             ),
                                //             SizedBox(height: 10),
                                //
                                //             Text(data.features![index].name ?? "",
                                //                 maxLines: 1,
                                //                 textAlign: TextAlign.center,
                                //                 style: regularFontStyle(size: 16,sizingInformation: sizingInformation)),
                                //           ],
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),

                                SizedBox(height: height * 0.027),
                                Text("ground_list".tr,style: mediumFontStyle(size: 26,color:  themeController.d.value//appTheme.black
                                )),
                                SizedBox(height: height * 0.014),

                                GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: data.subGrounds?.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: Get.width * 0.02, mainAxisSpacing: 10, mainAxisExtent: 245),
                                  itemBuilder: (_, index) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:  themeController.bgColor.value//appTheme.textfieldFillColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 130,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(image: NetworkImage(data.subGrounds?[index].image?[0] ?? ""),fit: BoxFit.cover),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(data.subGrounds?[index].name ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,style: boldFontStyle(size: 18.5, color: themeController.d.value//appTheme.black
                                              )),
                                          // SizedBox(height: 3),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Hour", style: regularFontStyle(size: 15, color: appTheme.dotted)),
                                              Text("${data.subGrounds?[index].duration.toStringAsFixed(2) } Hour", style: regularFontStyle(size: 15, color: appTheme.themeColor)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Price", style: regularFontStyle(size: 15, color: appTheme.dotted)),
                                              Text("₹${data.subGrounds?[index].price.toStringAsFixed(2) }/Hour", style: regularFontStyle(size: 15, color: appTheme.themeColor)),
                                            ],
                                          ),

                                        ],
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
          ),)
        );
      },
    );
  }
}