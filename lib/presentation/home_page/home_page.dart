import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/service/firebase_service.dart';

import 'package:sportsslot/core/utils/prefKeys.dart';

import 'package:sportsslot/presentation/detail_screen/controller/detail_controller.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';

import 'package:sportsslot/presentation/detail_screen/models/ground_list_model.dart';
import 'package:sportsslot/presentation/events_page/models/events_item_model.dart';
import 'package:sportsslot/presentation/filter_screen/controller/filter_controller.dart';

import 'package:sportsslot/presentation/search_screen/controller/search_controller.dart';
import 'package:sportsslot/widgets/app_bar/appbar_subtitle.dart';
import 'package:sportsslot/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:sportsslot/widgets/app_bar/custom_app_bar.dart';
import 'package:sportsslot/widgets/app_bar/custum_bottom_bar_controller.dart';
import 'package:sportsslot/widgets/custom_icon_button.dart';
import 'package:sportsslot/widgets/custom_search_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../categories_screen/controller/categories_controller.dart';
import '../categories_screen/models/categories_item_model.dart';
import '../categories_screen/widgets/categories_item_widget.dart';
import '../nearby_you_screen/controller/nearby_you_controller.dart';

import 'controller/home_controller.dart';
import 'models/home_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController controller = Get.put(HomeController(HomeModel().obs));
  CategoriesController categoriesController = Get.put(CategoriesController());
  NearbyYouController nearbyYouController = Get.put(NearbyYouController());
  SearchControllers searchControllers = Get.put(SearchControllers());
  DetailController detailController = Get.put(DetailController());
  FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return GetBuilder<HomeController>(
        id: "home",
        builder: (controller) =>
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [

                  Obx(() =>
                  controller.loader.value
                      ? Center(child: CircularProgressIndicator())
                      : Column(

                      children: [
                        buildAppBar(),
                        SizedBox(height: 5.v),
                        // _buildSearchbar(),
                        Divider(color:    appTheme.gray100,),
                        SizedBox(height: 5.v),
                        // SizedBox(height: 24.v),
                        Expanded(
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20.h, right: 20.h),

                                child: getViewAllRow("sportIcon".tr, () {
                                  Get.toNamed(
                                      AppRoutes.categoriesScreen, arguments: {
                                    "isFilter": false
                                  });
                                }),
                              ),
                              SizedBox(height: 16.v),

                              /// categories
                              SizedBox(
                                height: 50.v,
                                child: StreamBuilder<QuerySnapshot<Map<
                                    String,
                                    dynamic>>>(
                                    stream: FirebaseService.categoryCollection
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      categoriesController.categoriesData.clear();
                                      if (snapshot.hasData) {
                                        return  Padding(
                                            padding: EdgeInsets.only(left: 20.h, right: 20.h),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data?.docs.length,
                                              itemBuilder: (context, index){

                                                categoriesController.categoriesData
                                                    .add(
                                                    CategoriesItemModel(
                                                        snapshot.data
                                                            ?.docs[index]["id"],
                                                        snapshot.data
                                                            ?.docs[index]["image"],
                                                        snapshot.data
                                                            ?.docs[index]["name"],
                                                        appTheme.footBollColor));
                                                CategoriesItemModel model =
                                                CategoriesItemModel(
                                                    snapshot.data?.docs[index]["id"],
                                                    snapshot.data
                                                        ?.docs[index]["image"],
                                                    snapshot.data
                                                        ?.docs[index]["name"],
                                                    appTheme.footBollColor);

                                                return animationfunction(
                                                    index,
                                                    index < 4
                                                        ? CategoriesItemWidget(model,
                                                        isFilter: false,
                                                        onTapFootball: () {
                                                          Get.toNamed(
                                                              AppRoutes
                                                                  .footBallScreen,
                                                              arguments: {
                                                                "title": snapshot.data
                                                                    ?.docs[index]["name"],
                                                                "categoryId": snapshot
                                                                    .data
                                                                    ?.docs[index]["id"]
                                                              });
                                                        })
                                                        : SizedBox());
                                              }),
                                        );

                                      } else {
                                        return SizedBox();
                                        //   Center(
                                        //   child: CircularProgressIndicator(),
                                        // );
                                      }
                                    }),
                              ),
                              SizedBox(height: 27.v),

                              ///popular_ground
                              // Padding(
                              //   padding: EdgeInsets.only(left: 20.h, right: 20.h),
                              //   child: getViewAllRow("lbl_popular_ground".tr, () {
                              //     Get.toNamed(AppRoutes.popularGroundScreen);
                              //   }),
                              // ),
                              // SizedBox(height: 16.v),
                              // SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              //   child: Padding(
                              //     padding: EdgeInsets.symmetric(horizontal: 12.h),
                              //     child: Row(
                              //       children: List.generate(
                              //           popularGroundController.populerGround.length > 2
                              //               ? 2
                              //               : popularGroundController.populerGround.length,
                              //           (index) {
                              //         PopulargroundItemModel data =
                              //             popularGroundController.populerGround[index];
                              //         return animationfunction(
                              //             index,
                              //             Padding(
                              //               padding: EdgeInsets.symmetric(horizontal: 8.h),
                              //               child: GestureDetector(
                              //                 onTap: () {
                              //                   popularGroundController.currentimage = data.image!;
                              //                   popularGroundController.groundsLocation = data.location!;
                              //                   popularGroundController.groundName = data.title!;
                              //                   popularGroundController.update();
                              //                   Get.toNamed(AppRoutes.detailScreen);
                              //                 },
                              //                 child: Container(
                              //                   width: 260.h,
                              //                   decoration: AppDecoration.fillGray.copyWith(
                              //                     color: appTheme.textfieldFillColor,
                              //                     borderRadius: BorderRadiusStyle.roundedBorder16,
                              //                   ),
                              //                   child: Column(
                              //                     crossAxisAlignment: CrossAxisAlignment.start,
                              //                     children: [
                              //                       Hero(
                              //                         tag: data.image!,
                              //                         child: CustomImageView(
                              //                           imagePath: data.image,
                              //                           height: 126.v,
                              //                           width: double.infinity,
                              //                           radius: BorderRadius.circular(16.h),
                              //                           alignment: Alignment.topCenter,
                              //                         ),
                              //                       ),
                              //                       SizedBox(height: 12.v),
                              //                       Padding(
                              //                         padding: EdgeInsets.symmetric(horizontal: 16.h),
                              //                         child: Row(
                              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                           children: [
                              //                             Column(
                              //                               crossAxisAlignment: CrossAxisAlignment.start,
                              //                               children: [
                              //                                 Text(
                              //                                   data.title!,
                              //                                   style: theme.textTheme.titleMedium!.copyWith(color: appTheme.black900),
                              //                                 ),
                              //                                 SizedBox(height: 4.5.v),
                              //                                 Row(
                              //                                   children: [
                              //                                     CustomImageView(
                              //                                       color: appTheme.black900,
                              //                                       imagePath: ImageConstant.imgIcLocation,
                              //                                       height: 20.adaptSize,
                              //                                       width: 20.adaptSize,
                              //                                     ),
                              //                                     Padding(
                              //                                       padding: EdgeInsets.only(left: 8.h),
                              //                                       child: Text(data.location!, style: theme.textTheme.bodyMedium!.copyWith(color: appTheme.black900)),
                              //                                     ),
                              //                                   ],
                              //                                 )
                              //                               ],
                              //                             ),
                              //                             Row(
                              //                               children: [
                              //                                 CustomImageView(
                              //                                   imagePath: data.isBedMintan!
                              //                                       ? ImageConstant.imgShuttlecock31
                              //                                       : ImageConstant.imgShuttlecock1,
                              //                                   height: 24.adaptSize,
                              //                                   width: 24.adaptSize,
                              //                                 ),
                              //                                 SizedBox(width: 8.h),
                              //                                 CustomImageView(
                              //                                   imagePath: data.iscricket!
                              //                                       ? ImageConstant.imgBall1LightGreen400
                              //                                       : ImageConstant.imgTennisBall1,
                              //                                   height: 24.adaptSize,
                              //                                   width: 24.adaptSize,
                              //                                 ),
                              //                                 SizedBox(width: 8.h),
                              //                                 CustomImageView(
                              //                                   imagePath: data.isfootball!
                              //                                       ? ImageConstant.imgBasketBall
                              //                                       : ImageConstant.imgBasketBall,
                              //                                   height: 24.adaptSize,
                              //                                   width: 24.adaptSize,
                              //                                 ),
                              //                               ],
                              //                             )
                              //                           ],
                              //                         ),
                              //                       ),
                              //                       SizedBox(height: 16.5.v),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //             ));
                              //       }),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 24.v),
                              ///


                              Padding(
                                padding: EdgeInsets.only(left: 20.h, right: 20.h),
                                child: getViewAllRow("lbl_nearby_you".tr, () {
                                  Get.toNamed(AppRoutes.nearbyYouScreen);
                                }),
                              ),
                              SizedBox(height: 16.v),

                              controller.loader.value
                                  ? SizedBox()
                                  : controller.position == null
                                  ? Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: controller.permissionStatus,
                                            style: theme
                                                .textTheme.displayMedium!
                                                .copyWith(
                                                color: appTheme.black900,
                                                fontSize: 14)),
                                        WidgetSpan(
                                          alignment:
                                          PlaceholderAlignment.middle,
                                          child: GestureDetector(
                                            onTap: () async {
                                              // await openAppSettings();
                                              await controller.getCurrentLocation();
                                            },
                                            child: Text("Enable location service?",
                                                style: theme
                                                    .textTheme.displayMedium!
                                                    .copyWith(
                                                    color: appTheme
                                                        .buttonColor,
                                                    fontSize: 14)),
                                          ),
                                        ),
                                        // TextSpan(
                                        //     text: " Enable?",
                                        //     style: theme.textTheme.displayMedium!.copyWith(color:appTheme.buttonColor, fontSize: 14)),
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              )
                                  : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseService.groundListCollection
                                      .snapshots(),
                                  builder: (context, snapshot) {

                                    nearbyYouController.nearlyYoudata = [];
                                    searchControllers.searchRecentList = [];


                                    for (int i = 0; i <
                                        (snapshot.data?.docs.length ?? 0); i++) {
                                      var data = snapshot.data?.docs[i];

                                      detailController.groundList =
                                      []; //DetailModel.getGroundList();

                                      for (int i = 0; i <
                                          data?["subGrounds"].length; i++) {


                                        /// images key name
                                        detailController.groundList.add(
                                            GroundListModel(
                                                data?["subGrounds"][i]["id"],
                                                data?["subGrounds"][i]["image"],
                                                data?["subGrounds"][i]["name"],
                                                "${data?["subGrounds"][i]["duration"]} Hour",
                                                data?["subGrounds"][i]["price"],
                                                data?["subGrounds"][i]["timeShifts"]
                                            ));
                                      }


                                      double distance =
                                      Geolocator.distanceBetween(
                                        controller.position!.latitude,
                                        controller.position!.longitude,
                                        data?["mainGround"]["latitude"].toDouble(),
                                        data?["mainGround"]["longitude"].toDouble(),
                                      );

                                      double distanceInKm = distance / 1000;


                                      GroundDetailListModel groundDetailListModel = GroundDetailListModel(
                                        stadiumId: data?.id ?? "",
                                        image: data?["mainGround"]["image"],
                                        km: "${distanceInKm.toStringAsFixed(2)} km",
                                        latitude: data?["mainGround"]["latitude"]
                                            .toDouble(),
                                        longitude: data?["mainGround"]["longitude"]
                                            .toDouble(),
                                        price: "",
                                        //data?["price"].toStringAsFixed(2),
                                        title: data?["mainGround"]["name"]
                                            .toString() ?? "",
                                        description: data?["mainGround"]["description"]
                                            .toString() ?? "",
                                        getFacilityList: detailController
                                            .facilityList,
                                        getGroundList: detailController.groundList,
                                        features: data?["features"],
                                        review: data?["review"],
                                        categoryId: data?["categoryIdList"],
                                        // userId: PrefUtils.getString(PrefKey.userId),

                                      );


                                      if (distanceInKm < 20.00) {
                                        nearbyYouController.nearlyYoudata
                                            .add(groundDetailListModel);
                                      }

                                      searchControllers.searchRecentList.add(
                                          groundDetailListModel);
                                    }

                                    if (snapshot.hasData) {
                                      return (nearbyYouController.nearlyYoudata
                                          .isNotEmpty)
                                          ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.h),
                                            child: Row(
                                                children: List.generate(
                                                    nearbyYouController
                                                        .nearlyYoudata
                                                        .length ??
                                                        0, (index) {
                                                  GroundDetailListModel model = nearbyYouController
                                                      .nearlyYoudata[index];


                                                  return

                                                    FutureBuilder(
                                                        future: controller
                                                            .getLocationName(
                                                            model.latitude
                                                                .toDouble(),
                                                            model.longitude
                                                                .toDouble()),
                                                        builder: (context,
                                                            cityName) {
                                                          return animationfunction(
                                                              index,
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      8.h),
                                                                  child:
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Get.toNamed(
                                                                          AppRoutes
                                                                              .detailScreen,
                                                                          arguments: {
                                                                            "data": model,
                                                                          });
                                                                    },
                                                                    child:
                                                                    Container(
                                                                        width: 190.h,
                                                                        decoration: AppDecoration
                                                                            .fillGray
                                                                            .copyWith(
                                                                            color: appTheme.boxWhite,
                                                                            borderRadius: BorderRadiusStyle.roundedBorder16,
                                                                           border: Border.all(color: appTheme.boxBorder)

                                                                        ),
                                                                        child: Column(
                                                                            mainAxisSize:
                                                                            MainAxisSize
                                                                                .min,
                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              buildSeventeen(
                                                                                  image: model
                                                                                      .image[0],
                                                                                  distance: model
                                                                                      .km),
                                                                              SizedBox(
                                                                                  height: 18
                                                                                      .v),
                                                                              Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 100
                                                                                          .h,
                                                                                      child: Text(
                                                                                          model
                                                                                              .title,
                                                                                          overflow: TextOverflow
                                                                                              .ellipsis,
                                                                                          style: theme
                                                                                              .textTheme
                                                                                              .titleMedium!
                                                                                              .copyWith(
                                                                                              color: appTheme
                                                                                                  .black900)),
                                                                                    ),
                                                                                    Container(

                                                                                        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
                                                                                        decoration: AppDecoration.white
                                                                                            .copyWith(borderRadius: BorderRadiusStyle.circleBorder10),
                                                                                        child: Text(model
                                                                                            .km,
                                                                                            style: theme.textTheme.bodySmall!.copyWith(
                                                                                                color: theme.colorScheme.onErrorContainer,
                                                                                              fontFamily: 'Montserrat-Medium',
                                                                                            )))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                  height: 10
                                                                                      .v),
                                                                              Padding(
                                                                                padding: EdgeInsets
                                                                                    .symmetric(
                                                                                    horizontal: 8
                                                                                        .h),
                                                                                child: Row(
                                                                                  children: [
                                                                                    CustomImageView(
                                                                                      color: appTheme
                                                                                          .black900,
                                                                                      imagePath: ImageConstant
                                                                                          .imgIcLocation,
                                                                                      height: 20
                                                                                          .adaptSize,
                                                                                      width: 20
                                                                                          .adaptSize,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsets
                                                                                          .only(
                                                                                          left: 8
                                                                                              .h),
                                                                                      child: Text(
                                                                                          cityName
                                                                                              .data
                                                                                              .toString(),
                                                                                          //controller.locationList[index],
                                                                                          style: theme
                                                                                              .textTheme
                                                                                              .bodyMedium!
                                                                                              .copyWith(
                                                                                              color: appTheme
                                                                                                  .black900)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                  height: 16
                                                                                      .v)
                                                                            ])),
                                                                  ))
                                                          );
                                                        }
                                                    );
                                                })
                                            )
                                        ),
                                      )
                                          :
                                      Column(
                                        children: [
                                          SizedBox(height: 16.v),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text("no_data".tr,
                                                style: theme
                                                    .textTheme.displayMedium!
                                                    .copyWith(
                                                    color: appTheme
                                                        .buttonColor,
                                                    fontSize: 14)),
                                          ),

                                        ],
                                      );
                                    } else {
                                      return SizedBox();
                                      //   Center(
                                      //   child: CircularProgressIndicator(),
                                      // );
                                    }
                                  }),

                              SizedBox(height: 27.v),

                              Padding(
                                padding: EdgeInsets.only(left: 20.h, right: 20.h),
                                child: getViewAllRow("lbl_events".tr, () {
                                  Get.offAllNamed(AppRoutes.homeContainerScreen);
                                  CustomBottomBarController customBottomBarController = Get.put(CustomBottomBarController());
                                  customBottomBarController.getIndex(2);

                                }),
                              ),
                              SizedBox(height: 16.v),

                              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseService.eventListCollection
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return (snapshot.data!.docs.isNotEmpty)
                                          ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.h),
                                            child: Row(
                                                children: List.generate(
                                                    snapshot.data?.docs.length ??
                                                        0, (index) {
                                                  EventsItemModel model =
                                                  EventsItemModel(
                                                      snapshot.data
                                                          ?.docs[index]["eventImages"],
                                                      snapshot.data
                                                          ?.docs[index]["name"],
                                                      "location",
                                                      snapshot.data
                                                          ?.docs[index]["description"],
                                                      DateFormat('d MMMM, yyyy')
                                                          .format(snapshot.data
                                                          ?.docs[index]["endDate"]
                                                          .toDate()),
                                                      "₹${snapshot.data
                                                          ?.docs[index]["price"]
                                                          .toInt()}",
                                                      DateFormat('d MMMM, yyyy')
                                                          .format(snapshot.data
                                                          ?.docs[index]["startDate"]
                                                          .toDate()),
                                                      snapshot.data
                                                          ?.docs[index]["fromTime"] !=
                                                          null && snapshot.data
                                                          ?.docs[index]["toTime"] !=
                                                          null
                                                          ? "${DateFormat.jm()
                                                          .format(snapshot.data
                                                          ?.docs[index]["fromTime"]
                                                          .toDate())} - ${DateFormat
                                                          .jm().format(snapshot.data
                                                          ?.docs[index]["toTime"]
                                                          .toDate())}" : "-",
                                                      "ticketPrice",
                                                      "Start date ${DateFormat('d')
                                                          .format(snapshot.data
                                                          ?.docs[index]["timestamp"]
                                                          .toDate())} ${DateFormat(
                                                          'MMMM').format(
                                                          snapshot.data
                                                              ?.docs[index]["timestamp"]
                                                              .toDate())}",
                                                      snapshot.data
                                                          ?.docs[index]["preMemoryImages"],
                                                      snapshot.data
                                                          ?.docs[index]["url"]
                                                  );


                                                  return

                                                    animationfunction(
                                                        index,
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                8.h),
                                                            child:
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.toNamed(
                                                                    AppRoutes
                                                                        .eventsDetailScreen,
                                                                    arguments: {
                                                                      "data": model,
                                                                    }
                                                                );
                                                              },
                                                              child:
                                                              Container(
                                                                  width: 190
                                                                      .h,
                                                                  decoration: AppDecoration
                                                                      .fillGray
                                                                      .copyWith(
                                                                      color: appTheme.boxWhite,
                                                                      border: Border.all(color: appTheme.boxBorder),
                                                                      borderRadius: BorderRadiusStyle
                                                                          .roundedBorder16,

                                                                  ),

                                                                  child: Column(
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        buildSeventeen2(
                                                                            image: model
                                                                                .image![0]),
                                                                        SizedBox(
                                                                            height: 12
                                                                                .v),
                                                                        Padding(
                                                                          padding: EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8
                                                                                  .h),
                                                                          child: SizedBox(
                                                                            width: 280
                                                                                .h,

                                                                            child: Text(
                                                                                model
                                                                                    .tournamentName ??
                                                                                    "",
                                                                                overflow: TextOverflow
                                                                                    .ellipsis,
                                                                                style: theme
                                                                                    .textTheme
                                                                                    .titleMedium!
                                                                                    .copyWith(
                                                                                    color: appTheme
                                                                                        .black900)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height: 5
                                                                                .v),
                                                                        Padding(
                                                                          padding: EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8
                                                                                  .h),
                                                                          child: Text(
                                                                              model
                                                                                  .date ??
                                                                                  "",
                                                                              //controller.locationList[index],
                                                                              style: theme
                                                                                  .textTheme
                                                                                  .bodyMedium!
                                                                                  .copyWith(
                                                                                  color: appTheme
                                                                                      .black900)),
                                                                        ),
                                                                        SizedBox(
                                                                            height: 16
                                                                                .v)
                                                                      ])),
                                                            ))
                                                    );
                                                })
                                            )
                                        ),
                                      )
                                          : Column(
                                        children: [
                                          SizedBox(height: 16.v),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text("no_data_found".tr,
                                                style: theme
                                                    .textTheme.displayMedium!
                                                    .copyWith(
                                                    color: appTheme
                                                        .buttonColor,
                                                    fontSize: 14)),
                                          ),

                                        ],
                                      );
                                    } else {
                                      return SizedBox();
                                      //   Center(
                                      //   child: CircularProgressIndicator(),
                                      // );
                                    }
                                  }),
                              SizedBox(height: 24.v),
                            ],
                          ),
                        )


                      ]),
                  )



                  // Obx(() =>
                  // controller.loader.value
                  //     ? Center(child: CircularProgressIndicator())
                  //     : SizedBox())
                ],
              ),
            )
    );
  }

  /// Section Widget
  buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(left: 20.h, right: 20.h),
      child: CustomAppBar(
        height: 72.v,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarSubtitleOne(
                  text: controller.getGreetingBasedOnTime(),
                  margin: EdgeInsets.only(right: 79.h)),
              SizedBox(height: 5.v),
              AppbarSubtitle(text: "Hello ${PrefUtils.getString(PrefKey.fullName).split(" ")[0]}")
            ]),
        actions: [
          Row(
            children: [

              getCustomIconButton(ImageConstant.imgIcSearch, () {
                Get.toNamed(AppRoutes.searchScreen);
              }),
              SizedBox(width: 15.v,),

              getCustomIconButton(ImageConstant.imgGroup9, () {
                Get.toNamed(AppRoutes.notificationScreen);
              })

            ],
          )

        ]
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchbar() {
    return
      Padding(
        padding: EdgeInsets.only(right: 20.h, left: 20.h),
        child: CustomSearchView(
            onTap: () {
              Get.toNamed(AppRoutes.searchScreen);
            },
            textInputType: TextInputType.none,
            controller: controller.searchController,
            hintText: "lbl_search".tr));
  }

  /// Common widget
  Widget buildFrame1({
    required String popularGround,
    required String viewAll,
    Function? onTapViewAll,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(popularGround,
          style: theme.textTheme.titleLarge!
              .copyWith(color: theme.colorScheme.onErrorContainer,  fontFamily: 'Montserrat-Medium',)),
      GestureDetector(onTap: () {
        onTapViewAll!.call();
      }),
      Padding(
          padding: EdgeInsets.only(bottom: 3.v),
          child: Text(viewAll,
              style: CustomTextStyles.bodyLargeGray60001
                  .copyWith(color: appTheme.gray60001)))
    ]);
  }

  /// Navigates to the notificationEmptyScreen when the action is triggered.
  onTapIconButton() {
    Get.toNamed(
      AppRoutes.notificationEmptyScreen,
    );
  }

  /// Navigates to the filterScreen when the action is triggered.
  onTapBtnIconButton() {
    Get.toNamed(
      AppRoutes.filterScreen,
    );
  }

  /// Navigates to the categoriesScreen when the action is triggered.
  onTapTxtViewAll() {
    Get.toNamed(
      AppRoutes.categoriesScreen,
    );
  }

  /// Navigates to the popularGroundScreen when the action is triggered.
  onTapTxtViewAll1() {
    Get.toNamed(
      AppRoutes.popularGroundScreen,
    );
  }

  /// Navigates to the nearbyYouScreen when the action is triggered.
  onTapTxtViewAll2() {
    Get.toNamed(
      AppRoutes.nearbyYouScreen,
    );
  }

  Widget buildSeventeen({
    required String image,
    required String distance,
  }) {
    return SizedBox(
        height: 135.v,
        width: double.infinity,
        child: Stack(alignment: Alignment.topRight, children: [
          Hero(
            tag: image,
            child: CustomImageView(
                imagePath: image,
                height: 135.v,
                width: double.infinity,
                radius: BorderRadius.circular(16.h),
                alignment: Alignment.center),
          ),
          // Align(
          //     alignment: Alignment.topRight,
          //     child: Container(
          //         margin: EdgeInsets.only(top: 12.v, right: 12.h),
          //         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
          //         decoration: AppDecoration.white
          //             .copyWith(borderRadius: BorderRadiusStyle.circleBorder10),
          //         child: Text(distance,
          //             style: theme.textTheme.bodySmall!.copyWith(
          //                 color: theme.colorScheme.onErrorContainer)))
          // )
        ]));
  }

  Widget buildSeventeen2({
    required String image,
  }) {
    return SizedBox(
        height: 135.v,
        width: double.infinity,
        child: Hero(
          tag: image,
          child: CustomImageView(
              imagePath: image,
              height: 135.v,
              width: double.infinity,
              radius: BorderRadius.circular(16.h),
              alignment: Alignment.center),
        ));
  }
}
