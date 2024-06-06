import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// A controller class for the HomePage.
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/service/firebase_service.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/models/my_booking_upcoming_model.dart';
import 'package:sportsslot/presentation/nearby_you_screen/controller/nearby_you_controller.dart';
import 'package:sportsslot/widgets/app_bar/appbar_title.dart';
import 'package:sportsslot/widgets/app_bar/custum_bottom_bar_controller.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_text_form_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

///
/// This class manages the state of the HomePage, including the
/// current homeModelObj
bool isReview = false;

class HomeController extends GetxController {
  RxBool loader = false.obs;

  RxBool loaderDialog = false.obs;

  NearbyYouController nearbyYouController = Get.put(NearbyYouController());
  CustomBottomBarController customBottomBarController = Get.put(CustomBottomBarController());



  @override
  void onInit() {
    getData();


     if(isReview == false){
       forTakeReview();
     }

    // TODO: implement onInit
    super.onInit();
  }


  forTakeReview() async{

    isReview = true;

    loader.value = true;

   List completedData = [] ;

    var allUserData = await FirebaseFirestore.instance.collection(FirebaseKey.booking).get();

    if(allUserData.docs.isNotEmpty){
      await FirebaseFirestore.instance
          .collection(FirebaseKey.booking)
          .doc(PrefUtils.getString(PrefKey.userId))
          .collection(FirebaseKey.booking).get().then((value) async{

            for(var data in value.docs){
              var data2 = data;

              String selectDate = "${DateFormat('yyyy-MM-dd').format(data2["selectDate"].toDate())}";

              String? allStart = data2["selectTime"].split(" to ")[0].toString();
              String? hS = allStart.split(":").first;
              String? mS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
              String? pS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

              String? allEnd = data2["selectTime"].split(" to ")[1].toString();
              String? hE = allEnd.split(":").first;
              String? mE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
              String? pE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

              DateTime startTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hS:$mS $pS");
              DateTime endTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hE:$mE $pE");



              if(data2["isCancelBooking"] == false){
                 if(endTime.isBefore(DateTime.now())){

                   List reviewList = [];

                   await FirebaseService.groundListCollection.doc(data["stadiumId"]).get().then((value) {

                     if(value["review"].isEmpty){

                       completedData.add(
                           {
                             "startTime": startTime,
                             "endTime": endTime,
                             "stadiumId": data2["stadiumId"],
                             "stadiumName": data2["stadiumName"],
                             "image": data2["image"][0],
                             "subGround":  data2["subGroundDetail"]["subGroundName"],
                             "subGroundId": data2["subGroundDetail"]["subGroundId"],
                             "reviewList": value["review"],
                           }
                       );


                     }  else {

                       reviewList = value["review"];

                       bool isAdd = false;

                       for(int i=0; i<reviewList.length; i++){
                         if(reviewList[i]["userId"] == PrefUtils.getString(PrefKey.userId)){
                           isAdd = true;

                         } else{

                         }
                       }

                       if(!isAdd){
                         completedData.add(
                             {
                               "startTime": startTime,
                               "endTime": endTime,
                               "stadiumId": data2["stadiumId"],
                               "stadiumName": data2["stadiumName"],
                               "image": data2["image"][0],
                               "subGround":  data2["subGroundDetail"]["subGroundName"],
                               "subGroundId": data2["subGroundDetail"]["subGroundId"],
                               "reviewList": value["review"],
                             }
                         );
                       }
                     }
                   });

                }
              }
            }
      });
    }



   if(completedData.isNotEmpty){

     List endTime = completedData.map((data) {
       return data['endTime'];
     }).toList();


     DateTime? maxEndTime = endTime.isNotEmpty
         ? endTime.reduce((value, element) => value.isAfter(element) ? value : element)
         : null;



     for(var data in completedData){


       if(maxEndTime == data["endTime"]){
         ///showDialog
         showDialog(
           barrierDismissible: false,
           context: Get.context!,
           builder: (context) {
             return AlertDialog(
                 insetPadding: EdgeInsets.all(16.h),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
                 contentPadding: EdgeInsets.zero,
                 content: giveReviewDialog(
                   groundName: data["stadiumName"],
                   id: data["stadiumId"],
                   time: DateFormat('yyyy-MM-dd hh:mm a').format(data["endTime"]),
                   reviewList: data["reviewList"],
                 ));
           },
         );
       }
       }
     }

    loader.value = false;
  }

  getData() async {
    await getCurrentLocation();
    // if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
    //   await getNearLocation();
    // }
  }

  HomeController(this.homeModelObj);

  TextEditingController searchController = TextEditingController();

  TextEditingController iclocationController = TextEditingController();

  TextEditingController iclocationController1 = TextEditingController();

  Rx<HomeModel> homeModelObj;

  Position? position;

  String permissionStatus = "";

  bool? serviceEnabled;

  LocationPermission? permission;

  TextEditingController reviewController = TextEditingController();

  double rating2 = 1.0;

  String getGreetingBasedOnTime() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return 'lbl_good_morning'.tr;
    } else if (hour >= 12 && hour < 17) {
      return 'lbl_good_afternoon'.tr;
    } else if (hour >= 17 && hour < 21) {
      return 'lbl_good_evening'.tr;
    } else {
      return 'lbl_good_night'.tr;
    }
  }


  Future<Position?> getCurrentLocation() async {
    loader.value = true;
    bool permissionGranted = await handleLocationPermission();
    if (!permissionGranted) {
      update(["home"]);
      loader.value = false;
      return null;
    }
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(position);
      //await getNearLocation();
      update(["home"]);
      loader.value = false;
      return position;
    } catch (e) {
      update(["home"]);
      print('Error getting current location: $e');
      loader.value = false;
      return null;
    }
  }

  Future<bool> handleLocationPermission() async {
    loader.value = true;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      print('Location services are disabled. Please enable the services');
      update(["home"]);
      loader.value = false;
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permissionStatus = 'Location permissions are denied.';
        print(permissionStatus);
        loader.value = false;
        update(["home"]);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permissionStatus = 'Location permissions are denied.';
      await Geolocator.openAppSettings().then((value) async {
        permission = await Geolocator.checkPermission();
      });

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        await getCurrentLocation();
      } else {
        update(["home"]);
      }
      update(["home"]);
      return false;
    }
    update(["home"]);
    return true;
  }

  // getNearLocation () {
  //
  //   for(int  i = 0; i < nearbyYouController.nearlyYoudata.length; i++) {
  //     double distance = Geolocator.distanceBetween(
  //       // position!.latitude,
  //       21.2371937,
  //       // position!.longitude,
  //       72.885639,
  //       nearbyYouController.nearlyYoudata[i]['latitude']!,
  //       nearbyYouController.nearlyYoudata[i]['longitude']!,
  //     );
  //
  //     double distanceInKm = distance / 1000;
  //
  //     nearbyYouController.nearlyYoudata[i]["distance"] = distanceInKm;
  //
  //   }
  //
  //   nearbyYouController.nearlyYoudata = nearbyYouController.nearlyYoudata
  //       .where((location) => location['distance'] < 15.00)
  //       .toList();
  //
  //   print(nearbyYouController.nearlyYoudata);
  //
  // }


  getLocationName(var lat, var long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);


    return "${placemarks[0].subLocality ?? ""} ${placemarks[0].locality ?? ""}";
  }

  Widget giveReviewDialog({required String groundName, required String id, required String time, required List reviewList}){
    return Padding(
      padding: EdgeInsets.all(20),
      child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

         Stack(
           alignment: Alignment.center,
           children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisSize: MainAxisSize.min,
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Align(
                       alignment: Alignment.topLeft,
                       child: AppbarTitle(text: "lbl_write_a_review_for".tr),
                     ),
                     Text(
                       "Stadium: $groundName",
                       style: theme.textTheme.headlineMedium!.copyWith(
                           color: appTheme.gray600,
                           fontSize: 14
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 15.v),
                 CustomTextFormField(
                     controller: reviewController,
                     hintText: "msg_write_your_review".tr,
                     hintStyle: CustomTextStyles.bodyLargeGray60001,
                     filled: true,
                     fillColor: PrefUtils().getThemeData() == "primary" ? appTheme.textfieldFillColor : appTheme.bgColor,
                     textInputAction: TextInputAction.done,
                     maxLines: 7),

                 SizedBox(height: 5.v),

                 RatingBar.builder(
                   initialRating: 1,
                   minRating: 1,
                   direction: Axis.horizontal,
                   allowHalfRating: true,
                   glow: false,
                   itemCount: 5,
                   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                   itemBuilder: (context, _) =>
                       Icon(Icons.star, color: Colors.amber),
                   onRatingUpdate: (rating) {
                     rating2 = rating;
                   },
                 ),
                 SizedBox(height: 15.v),

                 Padding(
                   padding: EdgeInsets.only(
                       left: 20.h, right: 20.h, top: 16.v, bottom: 32.v),
                   child: CustomElevatedButton(
                       text: "lbl_submit_review".tr,
                       onPressed: loaderDialog.value ? (){} : () async {

                         loaderDialog.value = true;

                         if (reviewController.text.isEmpty) {
                           errorToast("Please enter your review");
                           loaderDialog.value = false;
                         } else {



                           Map reviewMap = {
                             "name": PrefUtils.getString(PrefKey.fullName),
                             "review": reviewController.text,
                             "star": rating2.toString(),
                             "userId": PrefUtils.getString(PrefKey.userId),
                             "time": DateTime.now()
                           };

                           try {

                             List reviews = [];

                             reviews.addAll(reviewList);

                             reviews.add(reviewMap);

                             await FirebaseService.groundListCollection.doc(id).update({
                               "review" : reviews
                             });

                             loaderDialog.value = false;
                             Get.back();

                           } catch (e) {
                             loaderDialog.value = false;
                           }
                         }
                       }),
                 ),
               ],
             ),
             Obx(() => loaderDialog.value ? Center(child: CircularProgressIndicator(),) : SizedBox()),
           ],
         ),

          ]),
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
