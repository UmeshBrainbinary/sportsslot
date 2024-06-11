import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/booking_details_one_screen/models/booking_details_one_model.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';
import 'package:sportsslot/widgets/app_bar/custum_bottom_bar_controller.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';
import '../detail_screen/controller/detail_controller.dart';
import 'controller/booking_details_one_controller.dart';
import 'package:http/http.dart' as http;


class BookingDetailsOneScreen extends StatefulWidget {
  const BookingDetailsOneScreen({super.key});

  @override
  State<BookingDetailsOneScreen> createState() =>
      _BookingDetailsOneScreenState();
}

class _BookingDetailsOneScreenState extends State<BookingDetailsOneScreen> {
  BookingDetailsOneController controller = Get.put(
      BookingDetailsOneController());
  DetailController detailController = Get.put(DetailController());


  late GroundDetailListModel groundDetailListModel;


  @override
  void initState() {
    groundDetailListModel = Get.arguments["model"];
    controller.location = Get.arguments["location"].toString();
    controller.bookingDate = Get.arguments["booking_date"];
    controller.bookingTime = Get.arguments["booking_time"].toString();
    controller.price = Get.arguments["price"].toString();
    controller.member = Get.arguments["member"].toString();
    controller.bookingCode = Get.arguments["bookingCode"].toString();
    controller.subGroundId = Get.arguments["subGroundId"].toString();
    controller.subGroundName = Get.arguments["subGroundName"].toString();
    controller.subGroundImage = Get.arguments["subGroundImage"].toString();


    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
          backgroundColor: appTheme.bgColor,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Obx(() => Stack(
              children: [
                SizedBox(
                    width: double.maxFinite,

                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          getCommonAppBar("lbl_booking_details".tr),
                          SizedBox(height: 16.v),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: CustomImageView(
                                imagePath: groundDetailListModel.image[0] ??
                                    ImageConstant.imgRectangle40185,
                                height: 180.v,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                radius: BorderRadius.circular(16.h)),
                          ),
                          SizedBox(height: 20.v),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: SizedBox(
                              width: 300.h,
                              child: Text(
                                // "msg_boys_and_girls_running".tr,
                                  groundDetailListModel.title ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleLarge!.copyWith(
                                      color: appTheme.black900)),
                            ),
                          ),
                          SizedBox(height: 5.v),
                          Padding(
                            padding: EdgeInsets.only(left: 20.h, right: 20.h),
                            child: Row(
                              children: [
                                CustomImageView(
                                  color: appTheme.black900,
                                  imagePath: ImageConstant.imgIcLocation,
                                  height: 20.adaptSize,
                                  width: 20.adaptSize,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text(
                                      controller.location,
                                      // "msg_agrasen_institute".tr,
                                      style: theme.textTheme.bodyMedium!.copyWith(
                                          color: appTheme.black900)
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 27.v),

                          ///lbl_facilities
                          // Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Padding(
                          //         padding: EdgeInsets.only(left: 20.h),
                          //         child: Text("lbl_facilities".tr,
                          //             style: theme.textTheme.titleLarge!.copyWith(
                          //               color: appTheme.black900,
                          //             )))),
                          // SizedBox(height: 19.v),
                          //     GridView.builder(
                          //       padding: EdgeInsets.symmetric(horizontal: 20.h),
                          //       primary: false,
                          //       shrinkWrap: true,
                          //       itemCount: detailController.facilityList.length,
                          //       gridDelegate:
                          //       SliverGridDelegateWithFixedCrossAxisCount(
                          //           mainAxisExtent: 85.v,
                          //           crossAxisCount: 4,
                          //           mainAxisSpacing: 16.h,
                          //           crossAxisSpacing: 16.h),
                          //       itemBuilder: (context, index) {
                          //         DetailscreenItemModel model =
                          //         detailController.facilityList[index];
                          //         return Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius:
                          //             BorderRadius.circular(12.h),
                          //             color: appTheme.textfieldFillColor,
                          //           ),
                          //           child: Padding(
                          //             padding: EdgeInsets.symmetric(horizontal: 10.h),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //               MainAxisAlignment.center,
                          //               crossAxisAlignment:
                          //               CrossAxisAlignment.center,
                          //               children: [
                          //                 Container(
                          //                   height: 40.v,
                          //                   width: 40.h,
                          //                   decoration: BoxDecoration(shape: BoxShape.circle, color: appTheme.whiteA700),
                          //                   child: Padding(
                          //                     padding:  EdgeInsets.all(10.h),
                          //                     child: CustomImageView(
                          //                       imagePath: model.icon,
                          //                       height: 24.adaptSize,
                          //                       width: 24.adaptSize,
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 SizedBox(height: 10.v),
                          //                 Text(model.title!,
                          //                     maxLines: 1,
                          //                     textAlign: TextAlign.center,
                          //                     style: CustomTextStyles.bodyMediumOnErrorContainer.copyWith(color: appTheme.black900)),
                          //               ],
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          // SizedBox(height: 24.v),

                          buildDetails(),
                          SizedBox(height: 5.v)
                        ])),
                controller.loader.value ? Center(child: CircularProgressIndicator()) : SizedBox()
              ],
            ),),
          ),
          bottomNavigationBar: buildButtons()),
    );
  }


  /// Section Widget
  Widget buildDetails() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 17.v),

        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16,
            color: appTheme.boxWhite, 
            border: Border.all(color: appTheme.boxBorder)),

        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
              padding: EdgeInsets.only(right: 3.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("lbl_ground".tr,
                        style: CustomTextStyles.bodyLargeGray60001),
                    SizedBox(
                      width: 200.h,
                      child: Text(controller.subGroundName ?? "",
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium!.copyWith(
                              color: appTheme.black900, fontSize: 16.fSize)),
                    )
                  ])),
          SizedBox(height: 20.v),
          _buildDate(date: "lbl_booking_code".tr,
              friSep: controller.bookingCode),
          SizedBox(height: 18.v),
          _buildDate(date: "lbl_date".tr,
              friSep: DateFormat("MMM. dd yyyy").format(
                  controller.bookingDate??DateTime.now())), // "lbl_fri_04_sep".tr),
          SizedBox(height: 18.v),
          _buildDate(date: "lbl_time".tr, friSep: controller.bookingTime),
          SizedBox(height: 18.v),
          _buildDate(date: "lbl_price".tr, friSep: controller.price),
          SizedBox(height: 18.v),
          _buildDate(date: "lbl_member".tr, friSep: controller.member),
        ]));
  }

  /// Section Widget
  Widget buildButtons() {
    return Obx(() => Container(
        width: double.infinity,

        decoration: AppDecoration.white.copyWith(
          color: appTheme.bgColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 20.h, right: 20.h, top: 16.v, bottom: 32.v),
          child: CustomElevatedButton(
              text: "msg_procced_to_payment".tr,

              onPressed: controller.loader.value ? (){} :() async {



                if(controller.loader.value == false){

                  controller.loader.value = true;

                  CollectionReference bookingRef = FirebaseFirestore.instance
                      .collection(FirebaseKey.booking).doc(
                      PrefUtils.getString(PrefKey.userId)).collection(
                      FirebaseKey.booking);

                  DocumentReference docRef = bookingRef.doc();
                  QuerySnapshot querySnapshot = await bookingRef.where(Keys.id, isEqualTo: docRef.id).get();

                  UserDetail userDetail = UserDetail(
                      userEmail: PrefUtils.getString(PrefKey.userEmail),
                      userId: PrefUtils.getString(PrefKey.userId),
                      userName: PrefUtils.getString(PrefKey.fullName),
                      userMobile: PrefUtils.getString(PrefKey.mobileNo));

                  SubGroundDetail subGroundDetail = SubGroundDetail(
                      subGroundId: controller.subGroundId,
                      subGroundName: controller.subGroundName,
                      price: controller.price,
                      image: controller.subGroundImage);

                  BookingModel bookingModel = BookingModel(
                      stadiumName: groundDetailListModel.title,
                      image: groundDetailListModel.image,
                      latitude: groundDetailListModel.latitude,
                      longitude: groundDetailListModel.longitude,
                      selectDate: controller.bookingDate,
                      selectTime: controller.bookingTime,
                      stadiumId: groundDetailListModel.stadiumId,
                      subGroundDetail: subGroundDetail,
                      bookingCode: controller.bookingCode,
                      registerTime: DateTime.now(),
                      userDetail: userDetail,
                      id: docRef.id,
                      member: controller.member,
                      isCancelBooking: false
                  );


                     /// --------------- logic -------------

                    //    bool isAddBooking = true;
                    //
                    // var allUserData = await FirebaseFirestore.instance.collection(FirebaseKey.booking).get();
                    //
                    // List<QueryDocumentSnapshot> allBookingData = [];
                    //
                    // if(allUserData.docs.isNotEmpty){
                    //
                    //   for(int j = 0 ; j<allUserData.docs.length; j++){
                    //
                    //     var userBookingData = await FirebaseFirestore.instance
                    //         .collection(FirebaseKey.booking)
                    //         .doc(allUserData.docs[j].id)
                    //         .collection(FirebaseKey.booking)
                    //         .get();
                    //
                    //     allBookingData.addAll(userBookingData.docs);
                    //
                    //   }
                    //
                    //
                    //   for(int i = 0 ; i<allBookingData.length; i++){
                    //
                    //     var data = allBookingData[i];
                    //
                    //     String bookingSelectDate = "${DateFormat('yyyy-MM-dd').format(data["selectDate"].toDate())}";
                    //
                    //     String? allStart = data["selectTime"].split(" to ")[0].toString();
                    //
                    //     String? hS = allStart.split(":").first;
                    //     String? mS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                    //     String? pS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();
                    //
                    //
                    //     String? allEnd = data["selectTime"].split(" to ")[1].toString();
                    //
                    //     String? hE = allEnd.split(":").first;
                    //     String? mE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                    //     String? pE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();
                    //
                    //     DateTime bookingStartTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${bookingSelectDate} $hS:$mS $pS");
                    //     DateTime bookingEndTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${bookingSelectDate} $hE:$mE $pE");
                    //
                    //     /// =========================
                    //
                    //
                    //     String selectDate = "${DateFormat('yyyy-MM-dd').format(controller.bookingDate)}";
                    //
                    //     String? timeStart = controller.bookingTime.split(" to ")[0].toString();
                    //     String? hS2 = timeStart.split(":").first;
                    //     String? mS2 = timeStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                    //     String? pS2 = timeStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();
                    //
                    //
                    //     String? timeEnd = controller.bookingTime.split(" to ")[1].toString();
                    //     String? hE2 = timeEnd.split(":").first;
                    //     String? mE2 = timeEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                    //     String? pE2 = timeEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();
                    //
                    //     DateTime selectStartTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hS2:$mS2 $pS2");
                    //     DateTime selectEndTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hE2:$mE2 $pE2");
                    //
                    //
                    //
                    //
                    //
                    //     if(data["stadiumId"] == groundDetailListModel.stadiumId
                    //         && data["subGroundDetail"]["subGroundId"] == subGroundDetail.subGroundId
                    //         && bookingSelectDate == selectDate
                    //         && data["selectTime"] != controller.bookingTime
                    //     ){
                    //       if ((selectStartTime.isBefore(bookingEndTime) && selectEndTime.isAfter(bookingStartTime)) ||
                    //           (selectStartTime.isAtSameMomentAs(bookingStartTime) || selectEndTime.isAtSameMomentAs(bookingEndTime))) {
                    //         //errorToast("This ground booking time is Overlapping");
                    //         isAddBooking = false;
                    //       }
                    //     } else if(
                    //     data["stadiumId"] == groundDetailListModel.stadiumId
                    //         && data["subGroundDetail"]["subGroundId"] == subGroundDetail.subGroundId
                    //         && bookingSelectDate == selectDate
                    //         && data["selectTime"] == controller.bookingTime
                    //     ){
                    //       isAddBooking = false;
                    //     }
                    //   }
                    // }
                    //
                    //
                    //
                    //
                    //
                    // if(isAddBooking == true){
                    //   await controller.addBookingData(bookingModel, docRef);
                    //   showDialog(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //           insetPadding: EdgeInsets.all(16.h),
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(20.h)),
                    //           contentPadding: EdgeInsets.zero,
                    //           content: confirmAddBooking());
                    //     },
                    //   );
                    //   print("======> booking added");
                    // } else{
                    //   errorToast("Ground already booked this time");
                    //   print("======> booking not add");
                    // }

                    /// -----------------

                  await controller.addBookingData(bookingModel, docRef);

                  await sendNotification(
                    title: "Stadium Booked successfully",
                    body: "${groundDetailListModel.title}, ${controller.subGroundName}",
                    dateTime: "${DateFormat('E, d MMMM yyyy').format(bookingModel.selectDate)} - ${controller.bookingTime}"
                  );


                  // showDialog(
                  //   barrierDismissible: false,
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //         insetPadding: EdgeInsets.all(16.h),
                  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
                  //         contentPadding: EdgeInsets.zero,
                  //         content: confirmAddBooking());
                  //   },
                  // );
                  CustomBottomBarController customBottomBarController = Get.put(CustomBottomBarController());
                  customBottomBarController.selectedIndex = 1;
                  customBottomBarController.getIndex(1);
                  Get.offAllNamed(AppRoutes.homeContainerScreen);

                  controller.loader.value = false;
                }

              }),
        )
    )
    );
  }

  /// Common widget
  Widget _buildDate({
    required String date,
    required String friSep,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(bottom: 1.v),
          child: Text(date,
              style: CustomTextStyles.bodyLargeGray60001
                  .copyWith(color: appTheme.gray60001))),
      Text(friSep,
          style: CustomTextStyles.titleMedium16
              .copyWith(color: appTheme.black900))
    ]);
  }

  /// Navigates to the selectDateTimeScreen when the action is triggered.
  onTapBookingDetails() {
    Get.toNamed(
      AppRoutes.selectDateTimeScreen,
    );
  }

  /// Navigates to the paymentScreen when the action is triggered.
  onTapProccedToPayment() {
    Get.toNamed(
      AppRoutes.paymentScreen,
    );
  }


 Widget confirmAddBooking(){
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
                Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: AppDecoration.fillPrimary
                        .copyWith(shape: BoxShape.circle),
                    child: Icon(Icons.check, size: 50, color: appTheme.white),
                    // CustomImageView(
                    //     imagePath: AssetRes.checkIcon,
                    //     color: appTheme.white,
                    //     height: 30,
                    //     alignment: Alignment.center,
                    //     fit: BoxFit.cover,
                    // )
                ),
                SizedBox(height: 19.v),
                Container(
                    width: 313.h,
                    margin: EdgeInsets.symmetric(horizontal: 21.h),
                    child: Text("mag_booking_confirmed".tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.titleLarge22.copyWith(
                            color: appTheme.black900,
                            height: 1.50))),
                //SizedBox(height: 15.v),
                // Text("msg_you_will_not_be".tr, style: theme.textTheme.bodyLarge!.copyWith(
                //     color: appTheme.black900,
                //     height: 1.50
                // )),
                SizedBox(height: 33.v),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.h, right: 20.h, top: 16.v, bottom: 32.v),
                  child: CustomElevatedButton(
                      text: "ok".tr,
                    onPressed: (){

                      CustomBottomBarController customBottomBarController = Get.put(CustomBottomBarController());
                      customBottomBarController.selectedIndex = 1;
                      customBottomBarController.getIndex(1);
                      Get.offAllNamed(AppRoutes.homeContainerScreen);
                    },
                )
                                )
              ],
            ),
            Obx(() => controller.loader.value ? Center(child: CircularProgressIndicator(),) : SizedBox())
          ],
        ),
      ]),
    );
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

       // showToast('Notification sent successfully');
      } else {
        //errorToast('Failed to send notification');
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

