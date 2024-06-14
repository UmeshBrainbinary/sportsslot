import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/my_booking_running_page/my_booking_running_page.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/models/my_booking_upcoming_model.dart';
import 'package:intl/intl.dart';

import '../my_booking_upcoming_page/controller/my_booking_upcoming_controller.dart';
import '../my_booking_upcoming_page/my_booking_upcoming_page.dart';
import 'controller/my_booking_upcoming_tab_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/my_booking_complated_page/my_booking_complated_page.dart';

class MyBookingUpcomingTabContainerScreen extends StatefulWidget {
  const MyBookingUpcomingTabContainerScreen({super.key});

  @override
  State<MyBookingUpcomingTabContainerScreen> createState() =>
      _MyBookingUpcomingTabContainerScreenState();
}

class _MyBookingUpcomingTabContainerScreenState
    extends State<MyBookingUpcomingTabContainerScreen> {
  MyBookingUpcomingTabContainerController controller =
      Get.put(MyBookingUpcomingTabContainerController());
  MyBookingUpcomingController myBookingUpcomingController =
      Get.put(MyBookingUpcomingController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return GetBuilder<MyBookingUpcomingController>(

        init: MyBookingUpcomingController(),
        builder: (myBookingUpcomingController) =>

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(left: 20.h, right: 20.h),
                  child: Text("lbl_my_booking".tr,
                      style: theme.textTheme.headlineMedium!
                          .copyWith(color: appTheme.black900)),
                ),
                SizedBox(height: 43.v),
                Container(
                  height: 32.v,
                  width: double.infinity,
                  child: TabBar(
                    controller: controller.tabviewController,
                    labelPadding: EdgeInsets.zero,
                    labelColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      fontSize: 16.fSize,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w600,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    //unselectedLabelColor: appTheme.gray60001,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16.fSize,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                    ),
                    indicatorColor: theme.colorScheme.primary,
                    //indicator: BoxDecoration(),
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: Text(
                          "lbl_upcoming".tr,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "lbl_running".tr,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "lbl_complated".tr,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.v),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebaseKey.booking)
                            .doc(PrefUtils.getString(PrefKey.userId))
                            .collection(FirebaseKey.booking)
                            .snapshots(),
                        builder: (context, snapshot) {

                          controller.getMyBookingUpcoming = [];
                          controller.getMyBookingRunning = [];
                          controller.getMyBookingUpCompleted = [];

                          for (int i = 0; i < (snapshot.data?.docs.length ?? 0); i++) {

                            var data2 = snapshot.data?.docs[i];

                            String selectDate = "${DateFormat('yyyy-MM-dd').format(data2?["selectDate"].toDate())}";

                            String? allStart = data2?["selectTime"].split(" to ")[0].toString();
                            String? hS = allStart?.split(":").first;
                            String? mS = allStart?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                            String? pS = allStart?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();


                            String? allEnd = data2?["selectTime"].split(" to ")[1].toString();
                            String? hE = allEnd?.split(":").first;
                            String? mE = allEnd?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                            String? pE = allEnd?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

                            DateTime startTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hS:$mS $pS");
                            DateTime endTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hE:$mE $pE");

                            if(data2?["isCancelBooking"] == false){
                              if(startTime.isAfter(DateTime.now())){
                                controller.getMyBookingUpcoming.add(
                                    MyBookingUpcomingModel(
                                      id: data2?["id"]??"",
                                      stadiumId: data2?["stadiumId"]??"",
                                      image: data2?["image"][0],
                                      title: data2?["stadiumName"],
                                      selectedDate:  "selectDate: ${DateFormat('MMMM d, yyyy').format(startTime)} \n startTime : ${DateFormat('hh:mm a').format(startTime)} \n endTime : ${DateFormat('hh:mm a').format(endTime)}",
                                      registerDateTime:  DateFormat('MMMM d, yyyy hh:mm a').format(data2?["registerTime"].toDate()),
                                      latitude:  data2?["latitude"],
                                      longitude:  data2?["longitude"],
                                      subGround:  data2?["subGroundDetail"]["subGroundName"],
                                      subGroundId: data2?["subGroundDetail"]["subGroundId"],
                                      bookingCode:  data2?["bookingCode"],
                                      date:  DateFormat('E, d MMMM yyyy').format(data2?["selectDate"].toDate()),
                                      time:  data2?["selectTime"],
                                      price:  data2?["subGroundDetail"]["price"],

                                    )
                                );
                              } else if(endTime.isBefore(DateTime.now())){
                                controller.getMyBookingUpCompleted.add(
                                    MyBookingUpcomingModel(
                                      id: data2?["id"]??"",
                                      stadiumId: data2?["stadiumId"]??"",
                                      image: data2?["image"][0],
                                      title: data2?["stadiumName"],
                                      selectedDate:  "selectDate: ${DateFormat('MMMM d, yyyy').format(startTime)} \n startTime : ${DateFormat('hh:mm a').format(startTime)} \n endTime : ${DateFormat('hh:mm a').format(endTime)}",
                                      registerDateTime:  DateFormat('MMMM d, yyyy hh:mm a').format(data2?["registerTime"].toDate()),
                                      latitude:  data2?["latitude"],
                                      longitude:  data2?["longitude"],
                                      subGround:  data2?["subGroundDetail"]["subGroundName"],
                                      subGroundId: data2?["subGroundDetail"]["subGroundId"],
                                      bookingCode:  data2?["bookingCode"],
                                      date:  DateFormat('E, d MMMM yyyy').format(data2?["selectDate"].toDate()),
                                      time:  data2?["selectTime"],
                                      price:  data2?["subGroundDetail"]["price"],

                                    )
                                );
                              } else{
                                controller.getMyBookingRunning.add(
                                    MyBookingUpcomingModel(
                                      id: data2?["id"]??"",
                                      stadiumId: data2?["stadiumId"]??"",
                                      image: data2?["image"][0],
                                      title: data2?["stadiumName"],
                                      selectedDate:  "selectDate: ${DateFormat('MMMM d, yyyy').format(startTime)} \n startTime : ${DateFormat('hh:mm a').format(startTime)} \n endTime : ${DateFormat('hh:mm a').format(endTime)}",
                                      registerDateTime:  DateFormat('MMMM d, yyyy hh:mm a').format(data2?["registerTime"].toDate()),
                                      latitude:  data2?["latitude"],
                                      longitude:  data2?["longitude"],
                                      subGround:  data2?["subGroundDetail"]["subGroundName"],
                                      subGroundId: data2?["subGroundDetail"]["subGroundId"],
                                      bookingCode:  data2?["bookingCode"],
                                      date:  DateFormat('E, d MMMM yyyy').format(data2?["selectDate"].toDate()),
                                      time:  data2?["selectTime"],
                                      price:  data2?["subGroundDetail"]["price"],

                                    )
                                );
                              }
                            }



                          }

                          if(snapshot.hasData){
                            return controller.getMyBookingUpcoming.isNotEmpty || controller.getMyBookingRunning.isNotEmpty || controller.getMyBookingUpCompleted.isNotEmpty
                                ?  SizedBox(
                              child: TabBarView(
                                controller: controller.tabviewController,
                                children: [
                                  MyBookingUpcomingPage(getMyBookingUpcoming: controller.getMyBookingUpcoming),
                                  MyBookingRunningPage(getMyBookingRunning: controller.getMyBookingRunning),
                                  MyBookingCompletedPage(getMyBookingCompleted: controller.getMyBookingUpCompleted),
                                ],
                              ),
                            )
                            : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 116.adaptSize,
                                    width: 116.adaptSize,
                                    padding: EdgeInsets.all(30.h),
                                    decoration: AppDecoration.fillPrimary.copyWith(
                                      borderRadius: BorderRadiusStyle.circleBorder58,
                                    ),
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgEdit1,
                                      height: 56.adaptSize,
                                      width: 56.adaptSize,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    "lbl_no_booking_yet".tr,
                                    // style: CustomTextStyles.titleMediumManropeGray60001,
                                    style: CustomTextStyles.titleMedium16.copyWith(
                                        color: appTheme.black),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })),
              ],
            ));
  }
}
