import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Common/loader.dart';
import 'package:sportsslot/web/Screen/booking_history/booking_history_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/model/booking_model.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BookingHistoryScreen extends StatefulWidget {
  BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {

  bookingHistoryController controller = Get.put(bookingHistoryController());
  ThemeController themeController = Get.find<ThemeController>();


@override
  void initState() {
  controller.getStadiumData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        if (sizingInformation.isDesktop) {
          // width = width/2;
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
              padding: EdgeInsets.symmetric(
                  horizontal: sizingInformation.isDesktop ? 30 : 24,
                  vertical: 25),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'bookingHistory'.tr,
                          style: mediumFontStyle(
                              size: 24, sizingInformation: sizingInformation),
                        ),

                      ],
                    ),
                  ),
                  Divider(height: 8),
                  SizedBox(height: height * 0.042),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectStartDate(context);
                          // setState(() {});
                        },
                        child: Container(
                          height: 40,
                          width: width * 0.3,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: themeController.c.value,//appTheme.white,
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

                                      sizingInformation: sizingInformation),
                                ),
                              ),
                              Image.asset(AssetRes.calendarIcon, color: appTheme.themeColor),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.017),
                      Text(
                        "To",
                        style: regularFontStyle(
                            size: 18, sizingInformation: sizingInformation),
                      ),
                      SizedBox(width: width * 0.017),
                      GestureDetector(
                        onTap: () {
                          controller.selectEndDate(context);
                          // setState(() {});
                        },
                        child: Container(
                          height: 40,
                          width: width * 0.3,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: themeController.c.value,//appTheme.white,
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
                  SizedBox(height: height * 0.035),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      // color: appTheme.themeColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12)),
                    ),
                    child: SizedBox(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          final double rowWidth = constraints.maxWidth;

                          return Row(
                            // chi
                            // direction: Axis.horizontal,
                            children: [
                              SizedBox(
                                width: rowWidth * 0.28,
                                child: Text(
                                  "stadium_name".tr,
                                  textAlign: TextAlign.center,
                                  style: mediumFontStyle(
                                      size: 21,
                                      sizingInformation: sizingInformation),
                                ),
                              ),
                              SizedBox(
                                width: rowWidth * 0.28,
                                child: Text(
                                  "totalUpcomingBooking".tr,
                                  textAlign: TextAlign.center,
                                  style: mediumFontStyle(
                                      size: 21,
                                      sizingInformation: sizingInformation),
                                ),
                              ),
                              SizedBox(
                                width: rowWidth * 0.28,
                                child: Text(
                                  "totalPreviousBooking".tr,
                                  textAlign: TextAlign.center,
                                  style: mediumFontStyle(
                                      size: 21,
                                      sizingInformation: sizingInformation),
                                ),
                              ),
                              SizedBox(
                                width: rowWidth * 0.16,
                                child: Text(
                                  "groundName".tr,
                                  textAlign: TextAlign.center,
                                  style: mediumFontStyle(
                                      size: 21,
                                      sizingInformation: sizingInformation),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                      ),
                      child: Obx(
                            () => controller.loader.value
                                ? Center(
                          child: CommonLoader(),
                        )
                                : ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.allStadiumDetails.value.length,
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return SizedBox(height: height * 0.016);
                          },
                          itemBuilder: (context, index) {
                            GroundDetailModel data = controller.allStadiumDetails.value[index];
                            List<int> booking = controller.getTotalUpcommingBookingBySubGround(data.subGrounds);
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                final double rowWidth =
                                    constraints.maxWidth;
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12)
                                          .copyWith(
                                          top: index == 0 ? 15 : 12),
                                      decoration: BoxDecoration(
                                          color: themeController.c.value,//appTheme.white,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: rowWidth * 0.28,
                                            child: Text(
                                              data.mainGround?.name ?? "",
                                              textAlign: TextAlign.center,
                                              style: regularFontStyle(
                                                  size: 19.5,
                                                  sizingInformation:
                                                  sizingInformation),
                                            ),
                                          ),
                                          SizedBox(
                                            width: rowWidth * 0.28,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [

                                                Text(
                                                  booking[0].toString(),
                                                  textAlign:
                                                  TextAlign
                                                      .center,
                                                  style: regularFontStyle(
                                                      size: 19,
                                                      sizingInformation:
                                                      sizingInformation,
                                                      height: 1.22),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: rowWidth * 0.28,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [

                                                Text(
                                                  booking[1].toString(),
                                                  textAlign:
                                                  TextAlign
                                                      .start,
                                                  style: regularFontStyle(
                                                      size: 19,
                                                      sizingInformation:
                                                      sizingInformation,
                                                      height: 1.22),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: rowWidth * 0.16,
                                            child: Row(
                                              children: [
                                                Spacer(),
                                                SizedBox(width: 3),
                                                SizedBox(
                                                  height: 34,
                                                  child:
                                                  CommonPrimaryButton(
                                                      height: 34,
                                                      text:
                                                      'viewDetails'.tr,
                                                      textStyle: regularFontStyle(
                                                          size: 16,
                                                          sizingInformation:
                                                          sizingInformation,
                                                          color: appTheme.white,
                                                          height: 0.59
                                                      ),
                                                      onTap: () {
                                                        controller.isShowSubGround.value[index] = !controller.isShowSubGround.value[index];
                                                        controller.isShowSubGround.refresh();
                                                      }),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Obx(() => controller
                                        .isShowSubGround.value[index]
                                        ? Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 7),
                                      margin: EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                        color: appTheme.themeColor,
                                        borderRadius:
                                        BorderRadius.only(
                                            topRight:
                                            Radius.circular(
                                                12),
                                            topLeft:
                                            Radius.circular(
                                                12)),
                                      ),
                                      child: SizedBox(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: rowWidth / 3,
                                                child: Text(
                                                  "groundName".tr,
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: mediumFontStyle(
                                                      size: 20,
                                                      color:
                                                      appTheme.white,
                                                      sizingInformation:
                                                      sizingInformation),
                                                ),
                                              ),
                                              SizedBox(
                                                width: rowWidth / 3,
                                                child: Text(
                                                  "totalUpcomingBooking"
                                                      .tr,
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: mediumFontStyle(
                                                      size: 20,
                                                      color:
                                                      appTheme.white,
                                                      sizingInformation:
                                                      sizingInformation),
                                                ),
                                              ),
                                              SizedBox(
                                                width: rowWidth / 3,
                                                child: Text(
                                                  "totalPreviousBooking"
                                                      .tr,
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: mediumFontStyle(
                                                      size: 20,
                                                      color:
                                                      appTheme.white,
                                                      sizingInformation:
                                                      sizingInformation),
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                        : SizedBox()),
                                    Obx(
                                          () =>
                                      controller.isShowSubGround
                                          .value[index]
                                          ? Container(
                                        decoration: BoxDecoration(
                                          color: themeController.c.value,//Colors.white,
                                          borderRadius:
                                          BorderRadius.only(
                                              bottomRight:
                                              Radius
                                                  .circular(
                                                  10),
                                              bottomLeft: Radius
                                                  .circular(
                                                  10)),
                                        ),
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: data
                                              .subGrounds
                                              ?.length ??
                                              0,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          separatorBuilder: (BuildContext
                                          context, int index) {
                                            return Divider(thickness: 1, height: 14, color: appTheme.colorCACACA);
                                          },
                                          itemBuilder: (context, index2) {
                                            final data2 = data.subGrounds?[index2];
                                            List<int> booking = controller.getTotalUpcommingBookingBySubGround([data2!]);

                                            return Padding(
                                              padding: EdgeInsets
                                                  .symmetric(
                                                  vertical:
                                                  12)
                                                  .copyWith(
                                                  top: index ==
                                                      0
                                                      ? 15
                                                      : 12),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                        rowWidth /
                                                            3,
                                                        child:
                                                        Text(
                                                          data2?.name ??
                                                              "",
                                                          textAlign:
                                                          TextAlign.center,
                                                          style: regularFontStyle(
                                                              size: 18,
                                                              sizingInformation: sizingInformation),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                        rowWidth /
                                                            3,
                                                        child:
                                                        Row(
                                                          children: [
                                                            Spacer(),
                                                            Container(
                                                              height: 35,
                                                              width: width * 0.215,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: appTheme.colorA8A8A8)),
                                                              child: IntrinsicHeight(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                                                      child: SizedBox(
                                                                        width: sizingInformation.isDesktop ? width * 0.13 : width * 0.12,
                                                                        child: Text(
                                                                          booking[0].toString(),
                                                                          textAlign: TextAlign.start,
                                                                          style: regularFontStyle(size: 18, sizingInformation: sizingInformation, height: 1.12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 35,
                                                                      child: VerticalDivider(thickness: 1, color: appTheme.colorA8A8A8),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () async{
                                                                        if(booking[0] > 0)
                                                                        {
                                                                          List<String> bookingIdList = controller.getTotalUpcomingBookingAndId(data2);
                                                                          controller.filterBookingList.value =controller.allBookingRecord.where((booking) => bookingIdList.contains(booking["id"])).toList();
                                                                          await  controller.bookingViewDialog(context: context, users: data2.users ?? [], bookingIdList: controller.bookingIdList.value,);
                                                                        }
                                                                        else{
                                                                          errorToast("no booking record found");
                                                                        }

                                                                      },
                                                                      child: Container(
                                                                        color: Colors.transparent,
                                                                        // height: sizingInformation.isDesktop ? width * 0.035 : width * 0.05,
                                                                        // width: sizingInformation.isDesktop ? width * 0.035 : width * 0.05,
                                                                        child: Padding(
                                                                          padding: EdgeInsets.only(left:sizingInformation.isDesktop ? 0.0 : 0,right:sizingInformation.isDesktop ? 10 : 6,top:sizingInformation.isDesktop ? 6.0 : 5,bottom:sizingInformation.isDesktop ? 6.0 : 5),
                                                                          child: Image.asset(AssetRes.eyeIcon, color: themeController.d.value,),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                        rowWidth /
                                                            3,
                                                        child:
                                                        Row(
                                                          children: [
                                                            Spacer(),
                                                            Container(
                                                              height: 35,
                                                              width: width * 0.215,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: appTheme.colorA8A8A8)),
                                                              child: IntrinsicHeight(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                                                      child: SizedBox(
                                                                        width: sizingInformation.isDesktop ? width * 0.13 : width * 0.12,
                                                                        child: Text(
                                                                          booking[1].toString(),
                                                                          textAlign: TextAlign.start,
                                                                          style: regularFontStyle(size: 18, sizingInformation: sizingInformation, height: 1.12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 35,
                                                                      child: VerticalDivider(thickness: 1, color: appTheme.colorA8A8A8),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () async{
                                                                        if(booking[1] > 0)
                                                                        {
                                                                          List<String> bookingIdList = controller.getTotalPreviousBookingAndId(data2);
                                                                          controller.filterBookingList.value =controller.allBookingRecord.where((booking) => bookingIdList.contains(booking["id"])).toList();
                                                                          await controller.bookingViewDialog(context: context, users: data2.users ?? [], bookingIdList: controller.bookingIdList.value);
                                                                        }
                                                                        else{
                                                                          errorToast("no booking record found");
                                                                        }

                                                                      },
                                                                      child: Container(
                                                                        color: Colors.transparent,
                                                                        // height: sizingInformation.isDesktop ? width * 0.055 : width * 0.05,
                                                                        // width: sizingInformation.isDesktop ? width * 0.055 : width * 0.05,
                                                                        child: Padding(
                                                                          // padding: EdgeInsets.all(sizingInformation.isDesktop ? 6.0 : 5),
                                                                          padding: EdgeInsets.only(left:sizingInformation.isDesktop ? 0.0 : 0,right:sizingInformation.isDesktop ? 10 : 6,top:sizingInformation.isDesktop ? 6.0 : 5,bottom:sizingInformation.isDesktop ? 6.0 : 5),
                                                                          child: Image.asset(AssetRes.eyeIcon, color: themeController.d.value,),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                          : SizedBox(),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizingInformation.isDesktop ? 20 : 13,
                          vertical: sizingInformation.isDesktop ? 15 : 12),
                      constraints: BoxConstraints(maxWidth: width * 0.63),
                      decoration: BoxDecoration(
                          color: themeController.c.value,//appTheme.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                              children: [
                                TextSpan(
                                    text: "${"totalBooking".tr} : ",
                                    style: regularFontStyle(
                                        size: 20,
                                        color: themeController.d.value,
                                        sizingInformation:
                                        sizingInformation)),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Obx(
                                        () =>  Text(
                                      controller.totalBooking.value.toString(),
                                      style: regularFontStyle(
                                          size: 20,
                                          color: appTheme.themeColor,
                                          sizingInformation: sizingInformation),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                              thickness: 1,
                              color: appTheme.dotted,
                              height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                  children: [
                                    TextSpan(
                                        text: "upComingBooking".tr,
                                        style: regularFontStyle(
                                            size: 20,
                                            color: themeController.d.value,
                                            sizingInformation:
                                            sizingInformation)),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Obx(
                                            () =>  Text(
                                          controller.totalUpcomming.value.toString(),
                                          style: regularFontStyle(
                                              size: 20,
                                              color: appTheme.themeColor,
                                              sizingInformation:
                                              sizingInformation),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: sizingInformation.isDesktop
                                      ? width * 0.04
                                      : width * 0.02),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "previousBooking".tr,
                                        style: regularFontStyle(
                                            size: 20,
                                            color: themeController.d.value,
                                            sizingInformation:
                                            sizingInformation)),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Obx(
                                            () =>  Text(
                                          (controller.totalBooking.value-controller.totalUpcomming.value).toString(),
                                          style: regularFontStyle(
                                              size: 20,
                                              color: appTheme.themeColor,
                                              sizingInformation:
                                              sizingInformation),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
  DateTime? startDate = DateTime(2024, 5, 1);
  DateTime? endDate = DateTime(2024, 5, 15);












}
