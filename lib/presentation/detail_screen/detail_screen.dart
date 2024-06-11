// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/service/firebase_service.dart';
import 'package:sportsslot/core/service/uni_link_service.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/presentation/detail_screen/widgets/detailscreen_item_widget.dart';
import 'package:sportsslot/presentation/nearby_you_screen/controller/nearby_you_controller.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:share_plus/share_plus.dart';
import '../popular_ground_screen/controller/popular_ground_controller.dart';
import '../review_screen/controller/review_controller.dart';
import '../review_screen/models/review_item_model.dart';
import '../review_screen/widgets/review_item_widget.dart';
import 'controller/detail_controller.dart';
import 'models/detailscreen_item_model.dart';
import 'models/ground_list_model.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  DetailController detailController = Get.put(DetailController());
  ReviewController reviewController = Get.put(ReviewController());
  PopularGroundController popularGroundController = Get.put(PopularGroundController());
  NearbyYouController nearbyYouController = Get.put(NearbyYouController());

  bool blockScroll = false;

  late GroundDetailListModel groundDetailListModel;

  @override
  void initState() {

    groundDetailListModel = Get.arguments["data"];
    detailController.currentGround = 0;
    detailController.selectGroundList = groundDetailListModel.getGroundList[0];


    /// review
    detailController.reviewListCount = groundDetailListModel.review.length;

    detailController.averageReview = 0.0;

    if(groundDetailListModel.review.isNotEmpty){
      for(int i = 0; i < groundDetailListModel.review.length; i++) {
        detailController.averageReview += double.parse(groundDetailListModel.review[i]["star"]);
      }

      detailController.averageReview = detailController.averageReview / detailController.reviewListCount;
    }


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
        body: SafeArea(
          child: GetBuilder<DetailController>(
            init: DetailController(),
            builder: (controller) => Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: CustomScrollView(
                      shrinkWrap: true,
                      primary: true,
                      physics: blockScroll
                          ? NeverScrollableScrollPhysics()
                          : BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          toolbarHeight: 68.v,
                          backgroundColor: Colors.transparent,
                          expandedHeight: 285.v,
                          leadingWidth: 68.h,
                          leading: Padding(
                            padding: EdgeInsets.only(left: 20.h, top: 16.v),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 48.v,
                                width: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.h),
                                  color: appTheme.blackTransperant
                                      .withOpacity(0.30),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.h),
                                  child: CustomImageView(
                                      imagePath:
                                          ImageConstant.imgGroup1171274870),
                                ),
                              ),
                            ),
                          ),
                          centerTitle: true,
                          actions: [
                            Padding(
                              padding: EdgeInsets.only(right: 20.h, top: 16.v),
                              child: GestureDetector(
                                onTap: () async {

                                },
                                child: Container(
                                  height: 48.v,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.h),
                                    color: appTheme.blackTransperant
                                        .withOpacity(0.30),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.h),
                                    child: CustomImageView(
                                        imagePath: ImageConstant.imgGroup1171274871),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                height: 285.v,
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      onPageChanged: (value) {
                                        controller.currentPage = value;
                                        controller.update();
                                      },
                                      controller: controller.pageController,
                                      itemCount:
                                          groundDetailListModel.image.length,
                                      itemBuilder: (context, index) {
                                        return Hero(
                                          tag: groundDetailListModel
                                              .image[index],
                                          child: CustomImageView(
                                            imagePath: groundDetailListModel
                                                .image[index],
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.h, bottom: 16.v),
                                      child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                              width: 64.h,
                                              height: 27.v,
                                              decoration: AppDecoration.white
                                                  .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .circleBorder10),
                                              child: Center(
                                                child: Text(
                                                    groundDetailListModel.km,

                                                    style: theme
                                                        .textTheme.bodySmall!
                                                        .copyWith(
                                                            color: theme
                                                                .colorScheme
                                                                .onErrorContainer)),
                                              ))),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            ListView(
                              padding: EdgeInsets.only(
                                  left: 20.h, right: 20.h, bottom: 120.v),
                              primary: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                SizedBox(height: 16.v),

                                buildReviews(),
                                SizedBox(height: 12.v),

                                ExpandableText(
                                  groundDetailListModel.description,
                                  expandText: "lbl_read_more".tr,
                                  collapseText: 'Read less',
                                  maxLines: 3,
                                  linkColor: appTheme.buttonColor,
                                  style: theme.textTheme.bodyLarge!
                                      .copyWith(color: appTheme.black900,  fontFamily: 'Montserrat-Medium',),
                                  linkStyle: theme.textTheme.titleMedium!
                                      .copyWith(
                                          color: appTheme.buttonColor,
                                          fontSize: 16.fSize,  fontFamily: 'Montserrat-Medium',),
                                ),

                                SizedBox(height: 24.v),

                                /// lbl_facilities
                                // Text(
                                //   "lbl_facilities".tr,
                                //   style: theme.textTheme.titleLarge!.copyWith(color:appTheme.black900),
                                // ),
                                // SizedBox(height: 19.v),
                                // GridView.builder(
                                //   primary: false,
                                //   shrinkWrap: true,
                                //   itemCount: groundDetailListModel.getFacilityList.length,
                                //   gridDelegate:
                                //       SliverGridDelegateWithFixedCrossAxisCount(
                                //           mainAxisExtent: 85.v,
                                //           crossAxisCount: 4,
                                //           mainAxisSpacing: 16.h,
                                //           crossAxisSpacing: 16.h),
                                //   itemBuilder: (context, index) {
                                //     DetailscreenItemModel model = groundDetailListModel.getFacilityList[index];
                                //     return Container(
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(12.h),
                                //         color: appTheme.textfieldFillColor,
                                //       ),
                                //       child: Padding(
                                //         padding: EdgeInsets.symmetric(horizontal: 10.h),
                                //         child: Column(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           children: [
                                //             Container(
                                //               height: 40.v,
                                //               width: 40.h,
                                //               decoration: BoxDecoration(shape: BoxShape.circle, color: appTheme.whiteA700),
                                //               child: Padding(
                                //                 padding:  EdgeInsets.all(10.h),
                                //                 child: CustomImageView(
                                //                   imagePath: model.icon,
                                //                   height: 24.adaptSize,
                                //                   width: 24.adaptSize,
                                //                 ),
                                //               ),
                                //             ),
                                //             SizedBox(height: 10.v),
                                //
                                //             Text(model.title!,
                                //                 maxLines: 1,
                                //                 textAlign: TextAlign.center,
                                //                 style: CustomTextStyles.bodyMediumOnErrorContainer.copyWith(color: appTheme.black900)),
                                //           ],
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                ///

                                SizedBox(height: 26.v),
                                Text(
                                  "lbl_ground_list".tr,
                                  style: theme.textTheme.titleLarge!
                                      .copyWith(color: appTheme.black900,  fontFamily: 'Montserrat-Medium'),
                                ),
                                SizedBox(height: 19.v),
                                ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: groundDetailListModel.getGroundList.length,
                                    itemBuilder: (context, index){
                                  GroundListModel model = groundDetailListModel.getGroundList[index];
                                  return DetailscreenItemWidget(model, index);
                                }),

                                SizedBox(height: 26.v),

                                Text(
                                  "msg_our_popular_features".tr,
                                  style: theme.textTheme.titleLarge!
                                      .copyWith(color: appTheme.black900,  fontFamily: 'Montserrat-Medium',),
                                ),

                                SizedBox(height: 19.v),

                                GridView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: groundDetailListModel.features.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 25.v,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16.h,
                                    crossAxisSpacing: 17.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 10.adaptSize,
                                            width: 10.adaptSize,
                                            margin: EdgeInsets.only(
                                                top: 8.v, bottom: 6.v),
                                            decoration: BoxDecoration(
                                                color:
                                                theme.colorScheme.primary,
                                                borderRadius:
                                                BorderRadius.circular(5.h)),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(left: 12.h),
                                            child: Text(
                                                groundDetailListModel.features[index]["name"],
                                                style: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(
                                                    color:
                                                    appTheme.black900)),
                                          ),
                                        ]);
                                  },
                                ),



                                SizedBox(height: 26.v),

                                getViewAllRow("lbl_reviews".tr, () {
                                  Get.toNamed(AppRoutes.reviewScreen, arguments: {
                                    "id": groundDetailListModel.stadiumId,
                                    "data": groundDetailListModel,
                                  });
                                }) ,

                                SizedBox(height: 16.v),

                                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseService.groundListCollection.doc(groundDetailListModel.stadiumId).snapshots(),
                                    builder: (context, snapshot){

                                      var data = snapshot.data;



                                      if(snapshot.hasData){
                                        return  data?["review"].isNotEmpty
                                        ? ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount:
                                            data?["review"].length > 1
                                                ? 1
                                                : data?["review"].length,
                                            itemBuilder: (context, index) {



                                              return  ReviewItemWidget(
                                                data: data?["review"][index],
                                              ) ;
                                            })
                                            : Center(
                                          child: Text("no_data_found".tr,
                                              style: theme
                                                  .textTheme.displayMedium!
                                                  .copyWith(
                                                  color: appTheme
                                                      .buttonColor,
                                                  fontSize: 14)),
                                        );
                                      } else{
                                        return SizedBox();
                                      }

                                    }
                                ),


                              ],
                            ),
                          ]),
                        ),
                      ],
                    ))
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: appTheme.bgColor,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 16.v, bottom: 32.v, left: 20.h, right: 20.h),
                      child: buildButtons(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget buildReviews() {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgIcStar,
                      height: 24.adaptSize,
                      width: 24.adaptSize),
                  Padding(
                      padding: EdgeInsets.only(left: 7.h, top: 3.v),
                      child: Text(
                          "${detailController.averageReview.toStringAsFixed(2)} (${detailController.reviewListCount} Reviews)" ,
                          style: CustomTextStyles.bodyLargeGray60001)),
                ],
              ),
              SizedBox(height: 12.v),
              SizedBox(
                width: 400.h,
                child: Text(groundDetailListModel.title,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleLarge22
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(left: 21.h, bottom: 38.v),
        //   child: Text("₹${groundDetailListModel.price}", style: CustomTextStyles.titleLargePrimary),
        // )
      ],
    );
  }

  /// Section Widget
  Widget buildButtons() {
    return CustomElevatedButton(
        text: "lbl_book_now".tr,
        onPressed: () {
          if (detailController.selectGroundList != null) {
            Get.toNamed(AppRoutes.selectDateTimeScreen, arguments: {
              "data": groundDetailListModel,
              "subGround": detailController.selectGroundList,
            });
          } else {
            errorToast("Please select ground");
          }
        });
  }

  /// Navigates to the nearbyYouScreen when the action is triggered.
  onTapIconButton() {
    Get.toNamed(
      AppRoutes.nearbyYouScreen,
    );
  }

  /// Navigates to the reviewScreen when the action is triggered.
  onTapTxtViewAll() {
    Get.toNamed(
      AppRoutes.reviewScreen,
    );
  }

  /// Navigates to the selectDateTimeScreen when the action is triggered.
  onTapBookNow() {
    Get.toNamed(
      AppRoutes.selectDateTimeScreen,
    );
  }
}
