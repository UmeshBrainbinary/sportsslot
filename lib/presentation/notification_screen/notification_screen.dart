// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import '../notification_screen/widgets/notification_item_widget.dart';
import 'controller/notification_controller.dart';
import 'models/notification_item_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController());


  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
          backgroundColor: appTheme.bgColor,
          body: SafeArea(
            child: GetBuilder<NotificationController>(
              init: NotificationController(),
              builder: (controller) =>
              // controller.notificationDataList.isEmpty
              //     ? Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           getCommonAppBar("lbl_notifications".tr),
              //           Column(
              //             children: [
              //               CustomImageView(
              //                   imagePath: ImageConstant.imgVectorPrimary,
              //                   height: 116.adaptSize,
              //                   width: 116.adaptSize),
              //               SizedBox(height: 20.v),
              //               Text("msg_no_notifications".tr,
              //                   style: CustomTextStyles.titleLarge22),
              //               SizedBox(height: 21.v),
              //               Text("msg_we_did_not_found".tr,
              //                   style: theme.textTheme.bodyLarge!.copyWith(
              //                     color: appTheme.black900,
              //                   )),
              //             ],
              //           ),
              //           SizedBox()
              //         ],
              //       )
              //     :
              Column(children: [
                      getCommonAppBar("lbl_notifications".tr),
                      SizedBox(height: 16.v),
                    Expanded(child:
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(

                        stream: FirebaseFirestore.instance.collection("Notification").snapshots(),
                        builder: (context, snapshot){

                          notificationController.notificationDataList = [];

                          if(snapshot.hasData){

                            for(var data in snapshot.data!.docs){
                              Duration difference = DateTime.now().difference(data["timeStamp"].toDate());
                              int minutesDifference = difference.inMinutes.abs();

                              NotificationItemModel model = NotificationItemModel(
                                  data["title"],
                                  data["description"],
                                  minutesDifference == 0 ? "Just now" : controller.getTimeAgo(minutesDifference),
                                  minutesDifference == 0 ? "Just now" : controller.getTimeAgo(minutesDifference)
                              );

                              notificationController.notificationDataList.add(model);
                            }

                            return  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("NotificationUser")
                                    .doc(PrefUtils.getString(PrefKey.userId))
                                    .collection("NotificationUser").snapshots(),
                                builder: (context, snapshot2){


                             if(snapshot2.hasData){

                               for(var data2 in snapshot2.data!.docs){
                                 Duration difference = DateTime.now().difference(data2["timeStamp"].toDate());
                                 int minutesDifference = difference.inMinutes.abs();

                                 NotificationItemModel model = NotificationItemModel(
                                     data2["title"],
                                     data2["description"],
                                     minutesDifference == 0 ? "Just now" : controller.getTimeAgo(minutesDifference),
                                     data2["dateTime"]
                                 );

                                 notificationController.notificationDataList.add(model);
                               }

                               return ListView.builder(
                                 padding: EdgeInsets.symmetric(horizontal: 20.h),
                                 primary: false,
                                 shrinkWrap: true,
                                 itemCount: notificationController.notificationDataList.length,
                                 physics: BouncingScrollPhysics(),
                                 itemBuilder: (context, index) {

                                   return animationfunction(
                                       index,
                                       Padding(
                                         padding: EdgeInsets.symmetric(vertical: 8.v),
                                         child: NotificationItemWidget(notificationController.notificationDataList[index]),
                                       ));

                                 },
                               );
                             } else{
                               return Center(
                                 child: CircularProgressIndicator(),
                               );
                             }

                            });
                          } else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }))

                    ]),
            ),
          )),
    );
  }

  /// Navigates to the homeContainerScreen when the action is triggered.
  onTapNotifications() {
    Get.toNamed(
      AppRoutes.homeContainerScreen,
    );
  }
}
