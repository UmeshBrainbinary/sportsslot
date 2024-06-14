import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/models/my_booking_upcoming_model.dart';
import 'package:intl/intl.dart';

import 'controller/history_upcoming_controller.dart';
import 'models/history_upcoming_model.dart';

// ignore_for_file: must_be_immutable
class HistoryUpcomingPage extends StatefulWidget {
  HistoryUpcomingPage({Key? key}) : super(key: key);

  @override
  State<HistoryUpcomingPage> createState() => _HistoryUpcomingPageState();
}

class _HistoryUpcomingPageState extends State<HistoryUpcomingPage> {
  HistoryUpcomingController controller = Get.put(HistoryUpcomingController());
  HomeController homeController = Get.put(HomeController(HomeModel().obs));

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseKey.booking)
            .doc(PrefUtils.getString(PrefKey.userId))
            .collection(FirebaseKey.booking)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            controller.historyList = [];

            for (int i = 0; i < (snapshot.data?.docs.length ?? 0); i++) {
              var data1 = snapshot.data?.docs[i];
              if (data1?["isCancelBooking"] == true) {
                controller.historyList.add(MyBookingUpcomingModel(
                  id: data1?["id"] ?? "",
                  image: data1?["image"][0],
                  title: data1?["stadiumName"],
                  selectedDate:
                      DateFormat('').format(data1?["selectDate"].toDate()),
                  registerDateTime: DateFormat('MMMM d, yyyy hh:mm a')
                      .format(data1?["registerTime"].toDate()),
                  latitude: data1?["latitude"],
                  longitude: data1?["longitude"],
                  subGround: data1?["subGroundDetail"]["subGroundName"],
                  bookingCode: data1?["bookingCode"],
                  date: DateFormat('E, d MMMM')
                      .format(data1?["selectDate"].toDate()),
                  time: data1?["selectTime"],
                  price: data1?["subGroundDetail"]["price"],
                ));
              }
            }

            return controller.historyList.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 4, left: 20.h, right: 20.h),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.historyList.length,
                    itemBuilder: (context, index) {
                      var data = controller.historyList[index];

                      return FutureBuilder(
                          future: homeController.getLocationName(
                              data.latitude, data.longitude),
                          builder: (context, cityName) {
                            return animationfunction(
                                index,
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.v),
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRoutes
                                                .historyComplateDetailScreen,
                                            arguments: {
                                              "data": data,
                                              "location":
                                                  cityName.data.toString()
                                            });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(4.h),
                                          decoration: AppDecoration.fillGray
                                              .copyWith(
                                                  color: appTheme.boxWhite,
                                                  border: Border.all(color: appTheme.boxBorder),
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder16),
                                          child: Row(children: [
                                            CustomImageView(
                                                imagePath: data.image,
                                                height: 90.adaptSize,
                                                width: 90.adaptSize,
                                                radius: BorderRadius.circular(
                                                    16.h)),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.h,
                                                    top: 8.v,
                                                    bottom: 5.v),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 180.h,
                                                        child: Text(
                                                            data.title ?? "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: theme
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    color: appTheme
                                                                        .black900)),
                                                      ),
                                                      SizedBox(height: 5.v),
                                                      _buildFrame1(
                                                          greece: cityName.data
                                                              .toString()),
                                                      SizedBox(height: 9.v),
                                                      Row(children: [
                                                        CustomImageView(
                                                            imagePath:
                                                                ImageConstant
                                                                    .imgIcBooking,
                                                            height:
                                                                20.adaptSize,
                                                            width:
                                                                20.adaptSize),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 7.h,
                                                                    top: 2.v),
                                                            child: Text(
                                                                data.date ?? "",
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium))
                                                      ])
                                                    ])),
                                            Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 18.h,
                                                    ),
                                                    child: Text(
                                                        data.price ?? "",
                                                        style: theme.textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                                color: appTheme
                                                                    .black900))),
                                              ],
                                            ),
                                          ]))),
                                ));
                          });
                    },
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
                        style: CustomTextStyles.titleMedium16.copyWith( color: appTheme.black),
                      ),
                    ],
                  ),
                );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  /// Common widget
  Widget _buildFrame1({required String greece}) {
    return Row(children: [
      CustomImageView(
          imagePath: ImageConstant.imgIcLocationGray60001,
          height: 20.adaptSize,
          width: 20.adaptSize),
      Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(greece,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: appTheme.gray60001)))
    ]);
  }

  /// Navigates to the historyDetailScreen when the action is triggered.
  onTapPreviousHistory() {
    Get.toNamed(
      AppRoutes.historyComplateDetailScreen,
    );
  }
}
