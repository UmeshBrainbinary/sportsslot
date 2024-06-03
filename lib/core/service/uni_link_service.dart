// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/foundation.dart';
// import 'package:sportsslot/core/service/firebase_service.dart';
// import 'package:sportsslot/presentation/detail_screen/controller/detail_controller.dart';
// import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
// import 'package:sportsslot/presentation/detail_screen/models/ground_list_model.dart';
// import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
// import 'package:sportsslot/presentation/home_page/models/home_model.dart';
// import 'package:sportsslot/routes/app_routes.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
//
// // import 'package:goblu_app/controller/home_controller.dart';
// // import 'package:goblu_app/controller/booking/ride_controller.dart';
// // import 'package:goblu_app/controller/user_controller.dart';
// // import 'package:goblu_app/screens/rides/address_pickup.dart';
// // import 'package:goblu_app/service/app_storage.dart';
// // import 'package:goblu_app/utils/app_constants.dart';
//
// class DynamicLinkService {
//   static final firebaseDynamicLinks = FirebaseDynamicLinks.instance;
//   static const androidParameters = AndroidParameters(
//     packageName: "com.flutterplaygroundbookingapp.app",
//   );
//   static const iosParameters = IOSParameters(
//     bundleId: "com.flutterplaygroundbookingapp.app",
//     appStoreId: ""//"6464328871",
//   );
//
//   static const uriPrefix = "https://flutterplaygroundbookingapp.page.link";
//   static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//
//
//
//   static  createReferralLink(
//       {required String stadiumId}) async {
//
//     final encodedPage = Uri.encodeQueryComponent(stadiumId);
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//         uriPrefix: uriPrefix,
//         link: Uri.parse('https://flutterplaygroundbookingapp.page.link?stadiumId=$stadiumId'),
//         androidParameters: androidParameters,
//         iosParameters: iosParameters);
//
//   // final link = await firebaseDynamicLinks.buildShortLink(parameters);
//
//     final  link = await parameters.link;
//
//     return link.toString();
//    // return link.shortUrl;
//   }
//
//   static Future handleDynamicLinks() async {
//     final data = await firebaseDynamicLinks.getInitialLink();
//     _handleDeepLink(data);
//
//     firebaseDynamicLinks.onLink.listen((dynamicLinkData) {
//       _handleDeepLink(dynamicLinkData);
//     });
//   }
//
//
//
//  static  Future<void> _handleDeepLink(PendingDynamicLinkData? data) async {
//
//
//
//     final Uri? deepLink = data?.link;
//     if (deepLink != null) {
//       print('_handleDeepLink | deeplink: $deepLink');
//       String? page = deepLink.queryParameters["page"];
//       String? refCode = deepLink.queryParameters["stadiumId"];
//
//       //We have added id parameter while creating dynamic link
//       //It will help you to find specific item from list and
//       /// id = ground(stadium id)
//
//
//       if (page != null) {
//         print('_handleDeepLink | page: $page');
//         if (page == "referAndEarn") {
//           // HomeController.to.changeTab(2);
//           // UserController.to.accountState = AccountState.refer;
//         } else if (page == "home") {
//           //HomeController.to.changeTab(0);
//         } else if (page == "pickup") {
//           // RideController.to.isPickupTyping = true;
//           // RideController.to.isDropTyping = false;
//           // RideController.to.placeList = [];
//           // RideController.to.isTyping = false;
//           // Get.to(() => AddressPickupScreen(
//           //     isPickup: true,
//           //     screen: 'goblu_home',
//           //   ),
//           // );
//
//
//
//           await FirebaseService.groundListCollection.doc(refCode).get().then((data) {
//
//             DetailController detailController = Get.put(DetailController());
//             HomeController controller = Get.put(HomeController(HomeModel().obs));
//
//
//             detailController.groundList = [];
//
//             for (int i = 0; i <
//                 data["subGrounds"].length; i++) {
//
//
//               /// images key name
//               detailController.groundList.add(
//                   GroundListModel(
//                       data["subGrounds"][i]["id"],
//                       data["subGrounds"][i]["image"],
//                       data["subGrounds"][i]["name"],
//                       "${data["subGrounds"][i]["duration"]} Hour",
//                       data["subGrounds"][i]["price"],
//                       data["subGrounds"][i]["timeShifts"]
//                   ));
//             }
//
//
//             double distance =
//             Geolocator.distanceBetween(
//               controller.position!.latitude,
//               controller.position!.longitude,
//               data["mainGround"]["latitude"].toDouble(),
//               data["mainGround"]["longitude"].toDouble(),
//             );
//
//             double distanceInKm = distance / 1000;
//
//
//             GroundDetailListModel model = GroundDetailListModel(
//               stadiumId: data.id ?? "",
//               image: data["mainGround"]["image"],
//               km: "${distanceInKm.toStringAsFixed(2)} km",
//               latitude: data["mainGround"]["latitude"]
//                   .toDouble(),
//               longitude: data["mainGround"]["longitude"]
//                   .toDouble(),
//               price: "",
//               //data?["price"].toStringAsFixed(2),
//               title: data["mainGround"]["name"]
//                   .toString() ?? "",
//               description: data["mainGround"]["description"]
//                   .toString() ?? "",
//               getFacilityList: detailController
//                   .facilityList,
//               getGroundList: detailController.groundList,
//               features: data["features"],
//               review: data["review"],
//               categoryId: data["categoryIdList"],
//               // userId: PrefUtils.getString(PrefKey.userId),
//
//             );
//
//
//
//             Get.toNamed(
//                 AppRoutes
//                     .detailScreen,
//                 arguments: {
//                   "data": model,
//                 });
//
//           });
//
//
//
//
//
//
//
//         }
//       }else if(refCode != null){
//         print('Code found >> $refCode');
//         //await AppStorage.set(AppConstants.refCode, refCode);
//       } else {
//         debugPrint('_handleDeepLink | page parameter not found');
//       }
//     }
//   }
// }