import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/service/firebase_service.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/review_screen/controller/review_controller.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_text_form_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'controller/write_a_review_controller.dart';

class WriteAReviewScreen extends StatefulWidget {
  const WriteAReviewScreen({super.key});

  @override
  State<WriteAReviewScreen> createState() => _WriteAReviewScreenState();
}

class _WriteAReviewScreenState extends State<WriteAReviewScreen> {
  ReviewController reviewController = Get.put(ReviewController());
  WriteAReviewController controller = Get.put(WriteAReviewController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appTheme.bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  getCommonAppBar("lbl_write_a_review".tr),
                  SizedBox(height: 16.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: CustomTextFormField(
                          controller: controller.reviewController,
                          hintText: "msg_write_your_review".tr,
                          hintStyle: CustomTextStyles.bodyLargeGray60001,
                          textInputAction: TextInputAction.done,
                          maxLines: 7)),
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
                      controller.rating = rating;
                      print(controller.rating);
                    },
                  ),
                ])),
            Obx(() => controller.loader.value ? Center(child: CircularProgressIndicator(),) : SizedBox()),

          ],
        ),
      ),
      bottomNavigationBar: Container(
          width: double.infinity,
          decoration: AppDecoration.white.copyWith(color: appTheme.bgColor),
          child: Padding(
            padding: EdgeInsets.only(
                left: 20.h, right: 20.h, top: 16.v, bottom: 32.v),
            child: CustomElevatedButton(
                text: "lbl_submit_review".tr,
                onPressed: controller.loader.value ? (){} : () async {

                  controller.loader.value = true;

                  if (controller.reviewController.text.isEmpty) {
                    errorToast("Please enter your review");
                    controller.loader.value = false;
                  } else {

                    //reviewController.allReview = jsonDecode(PrefUtils.getString("reviews"));

                    // reviewController.allReview.add({
                    //   "name" : "Floyd Miles",
                    //   "review" : controller.group1171274964Controller.text,
                    //   "star" : controller.rating.toString(),
                    //   "userName": PrefUtils.getString(PrefKey.fullName),
                    //   "userId": PrefUtils.getString(PrefKey.userId),
                    //   "time": DateTime.now()
                    // });

                    //await PrefUtils.setValue("reviews", jsonEncode(reviewController.allReview));

                    // reviewController.update(["review"]);
                    // Get.back(result: true);
                    // reviewController.update(["review"]);
                    // Get.back();

                    Map reviewMap = {
                      "name": PrefUtils.getString(PrefKey.fullName),
                      "review": controller.reviewController.text,
                      "star": controller.rating.toString(),
                      "userId": PrefUtils.getString(PrefKey.userId),
                      "time": DateTime.now()
                    };

                    try {

                      List reviewList = [];

                        await FirebaseService.groundListCollection.doc(reviewController.stadiumId).get().then((value) {

                          if(value["review"].isEmpty){

                            reviewList.add(reviewMap);

                          }  else {

                            reviewList = value["review"];


                            bool isAdd = false;

                              for(int i=0; i<reviewList.length; i++){
                                if(reviewList[i]["userId"] == PrefUtils.getString(PrefKey.userId)){
                                  isAdd = true;
                                  reviewList[i] = reviewMap;

                                } else{

                                }
                              }

                              if(!isAdd){
                                reviewList.add(reviewMap);
                              }

                          }

                        });

                        await FirebaseService.groundListCollection.doc(reviewController.stadiumId).update({
                          "review" : reviewList
                        });

                      controller.loader.value = false;
                      Get.back();

                    } catch (e) {
                      controller.loader.value = false;
                    }
                  }
                }),
          )),
    );
  }

  /// Section Widget
  Widget _buildButtons() {
    return Container(
        width: double.infinity,
        decoration: AppDecoration.white.copyWith(color: appTheme.bgColor),
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.h, right: 20.h, top: 16.v, bottom: 32.v),
          child: CustomElevatedButton(
              text: "lbl_submit_review".tr,
              onPressed: () {
                Get.back();
              }),
        ));
  }

  /// Navigates to the reviewScreen when the action is triggered.
  onTapWriteAReview() {
    Get.toNamed(
      AppRoutes.reviewScreen,
    );
  }

  /// Navigates to the reviewScreen when the action is triggered.
  onTapSubmitReview() {
    Get.toNamed(
      AppRoutes.reviewScreen,
    );
  }
}
