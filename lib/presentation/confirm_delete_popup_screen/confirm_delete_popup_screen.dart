import 'dart:convert';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/booking_details_screen/controller/booking_details_controller.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/widgets/app_bar/custum_bottom_bar_controller.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_outlined_button.dart';
import 'package:intl/intl.dart';
import 'controller/confirm_delete_popup_controller.dart';

class ConfirmDeletePopupScreen extends GetWidget<ConfirmDeletePopupController> {
   ConfirmDeletePopupScreen({Key? key}) : super(key: key);

  ConfirmDeletePopupController controller =Get.put(ConfirmDeletePopupController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Container(
        width: double.maxFinite,
        child: _buildCancel());
  }

  /// Section Widget
  Widget _buildCancel() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 32.v),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, children: [
       Stack(
         alignment: Alignment.center,
         children: [
           Column(
             mainAxisSize: MainAxisSize.min,
             children: [

               SizedBox(height: 19.v),
               Container(
                   width: 313.h,
                   margin: EdgeInsets.symmetric(horizontal: 21.h),
                   child: Text("msg_are_you_sure_you".tr,
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                       textAlign: TextAlign.center,
                       style: CustomTextStyles.titleLarge22.copyWith(
                           color: appTheme.black900,
                           height: 1.50))),
               SizedBox(height: 15.v),
               Text("msg_you_will_not_be".tr, style: theme.textTheme.bodyLarge!.copyWith(
                   color: appTheme.black900,
                   height: 1.50
               )),
               SizedBox(height: 33.v),
               Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                 Expanded(
                     child: CustomOutlinedButton(
                         text: "lbl_cancel".tr,
                         margin: EdgeInsets.only(right: 8.h),
                         onPressed: () {
                           onTapCancel();
                         })),
                 Expanded(
                     child: Obx(() => CustomElevatedButton(
                         text: "lbl_delete".tr,
                         margin: EdgeInsets.only(left: 8.h),
                         onPressed: controller.loader.value ? (){} : () {
                           onTapDelete();
                         })))
               ])
             ],
           ),
           Obx(() => controller.loader.value ? Center(child: CircularProgressIndicator(),) : SizedBox())
         ],
       ),
      ]),
    );
  }

  /// Navigates to the profileScreen when the action is triggered.
  onTapCancel() {
   Get.back();
  }

  /// Navigates to the profileScreen when the action is triggered.
  onTapDelete() async {
    BookingDetailsController bookingDetailsController = Get.put(BookingDetailsController());
    controller.loader.value = true;

   try{


     await FirebaseFirestore.instance
         .collection(FirebaseKey.booking)
         .doc(PrefUtils.getString(PrefKey.userId))
         .collection(FirebaseKey.booking).doc(bookingDetailsController.data.id).update({
       "isCancelBooking" : true,
     });


     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
         .collection(FirebaseKey.admin)
         .doc(FirebaseKey.groundDetails)
         .collection(FirebaseKey.groundDetails)
         .doc(bookingDetailsController.data.stadiumId)
         .get();

     if (documentSnapshot.exists) {

       Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
       GroundDetailModel groundData = GroundDetailModel.fromMap(map);
       List<SubGround> subGroundList = groundData.subGrounds ?? [];


       String bookingId = bookingDetailsController.data.id??"";
       String userId = PrefUtils.getString(PrefKey.userId);


       String selectedSubGroundId = bookingDetailsController.data.subGroundId??"";

       if (groundData.subGrounds != null) {
         for (int i = 0; i < groundData.subGrounds!.length; i++) {
           if (groundData.subGrounds![i].id == selectedSubGroundId) {

             for(int j = 0; j<(groundData.subGrounds?[i].users?.length??0); j++){

               if(groundData.subGrounds?[i].users?[j].uid == userId){
                 if(groundData.subGrounds![i].users?[j].bookingId.length == 1){
                   groundData.subGrounds![i].users?.removeAt(j);
                 } else{
                   groundData.subGrounds![i].users?[j].bookingId.remove(bookingId);
                 }
               }


              
             }

           }
         }
       }


       
       GroundDetailModel newGroundData = GroundDetailModel(
         categoryIdList: groundData.categoryIdList,
         categories: groundData.categories,
         features: groundData.features,
         mainGround: groundData.mainGround,
         subGrounds: subGroundList,
         timestamp: groundData.timestamp,
         review: groundData.review,
       );
       
    /// update

       await FirebaseFirestore.instance
           .collection(FirebaseKey.admin)
           .doc(FirebaseKey.groundDetails)
           .collection(FirebaseKey.groundDetails)
           .doc(bookingDetailsController.data.stadiumId).update(newGroundData.toMap());
      
     }
     else{

     }


     await sendNotification(
         title: "Stadium canceled successfully",
         body: "${bookingDetailsController.data.title}, ${bookingDetailsController.data.subGround}",
         dateTime: "${bookingDetailsController.data.date} - ${bookingDetailsController.data.time}"
     );



     controller.loader.value = false;

     Get.offAllNamed(AppRoutes.homeContainerScreen);
     CustomBottomBarController customBottomBarController = Get.put(CustomBottomBarController());
     customBottomBarController.getIndex(3);
   } catch(e){
     controller.loader.value = false;

   }

  }

   Future<void> sendNotification(
       {required String title, required String body, required String dateTime}) async {

     final String serverKey = 'AAAA5hZ0uDs:APA91bHBrpeWwsqv78mQhgfh0avukwgYAxrVWV-JYkNiNen75XsGz0hLnN3nYBhUXzRM_buROQyB_DAlCAV8z0j4gYxSzh2mFRf0C8bcMG5zfmzV-i6KqIPrQBSCiuI8Jo-o0ibk07pF';
     final String url = 'https://fcm.googleapis.com/fcm/send';

     Map<String, dynamic> payload = {
       'notification': {
         'title': title,
         'body': body,
       },
       'registration_ids': [PrefUtils.getString(PrefKey.fcmToken)],
     };

     final String encodedPayload = json.encode(payload);

     final Map<String, String> headers = {
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverKey',
     };

     try {
       final http.Response response = await http.post(
         Uri.parse(url),
         headers: headers,
         body: encodedPayload,
       );
       if (response.statusCode == 200) {
         await addNotificationToCollection(title: title, body: body, dateTime: dateTime);
         //showToast('Notification sent successfully');
       } else {
        // errorToast('Failed to send notification');
       }
     } catch (e) {
       print('Error sending notification: $e');
     }
   }

   Future<void> addNotificationToCollection({required String title, required String body, required String dateTime}) async{
     try{

       Map<String,dynamic> notification = {
         "title": title,
         "description": body,
         "timeStamp": DateTime.now(),
         'dateTime': dateTime
       };

       await FirebaseFirestore.instance
           .collection("NotificationUser")
           .doc(PrefUtils.getString(PrefKey.userId))
           .collection("NotificationUser")
           .add(notification);
     }
     catch(e){
       debugPrint("Error while adding: $e");
       rethrow;
     }
   }

  
}
