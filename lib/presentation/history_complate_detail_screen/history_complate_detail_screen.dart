// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:sportsslot/presentation/history_upcoming_page/models/history_upcoming_model.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/models/my_booking_upcoming_model.dart';

import '../detail_screen/controller/detail_controller.dart';

import 'controller/history_complate_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';



class HistoryComplateDetailScreen extends StatefulWidget {
  const HistoryComplateDetailScreen({super.key});

  @override
  State<HistoryComplateDetailScreen> createState() => _HistoryComplateDetailScreenState();
}

class _HistoryComplateDetailScreenState extends State<HistoryComplateDetailScreen> {
  HistoryComplateDetailController controller = Get.put(HistoryComplateDetailController());
  DetailController detailController = Get.put(DetailController());

late MyBookingUpcomingModel historyUpcomingModel;
  @override
  void initState() {
    // TODO: implement initState
    historyUpcomingModel = Get.arguments["data"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: ()async {
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: appTheme.bgColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCommonAppBar("lbl_history_detail".tr),
              SizedBox(height: 16.v),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.h),
                child: CustomImageView(
                  imagePath: historyUpcomingModel.image,
                  height: 180.v,
                  width: double.infinity,
                  radius: BorderRadius.circular(
                    16.h,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 20.v),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Text(
                  historyUpcomingModel.title??"",
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: appTheme.black900,
                  ),
                ),
              ),
              SizedBox(height: 5.v),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Row(
                  children: [
                    CustomImageView(
                      color: appTheme.black900,
                      imagePath: ImageConstant.imgIcLocation,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        top: 2.v,
                      ),
                      child: Text(
                        "lbl_bangalore".tr,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: appTheme.black900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 27.v),
              ///lbl_facilities
              // Padding(
              //   padding: EdgeInsets.only(left: 20.h),
              //   child: Text(
              //     "lbl_facilities".tr,
              //     style: theme.textTheme.titleLarge!.copyWith(
              //       color: appTheme.black900,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 19.v),
              // GridView.builder(
              //   padding: EdgeInsets.symmetric(horizontal: 20.h),
              //   primary: false,
              //   shrinkWrap: true,
              //   itemCount: detailController.facilityList.length,
              //   gridDelegate:
              //   SliverGridDelegateWithFixedCrossAxisCount(
              //       mainAxisExtent: 85.v,
              //       crossAxisCount: 4,
              //       mainAxisSpacing: 16.h,
              //       crossAxisSpacing: 16.h),
              //   itemBuilder: (context, index) {
              //     DetailscreenItemModel model =
              //     detailController.facilityList[index];
              //     return Container(
              //       decoration: BoxDecoration(
              //         borderRadius:
              //         BorderRadius.circular(12.h),
              //         color: appTheme.textfieldFillColor,
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.symmetric(
              //             horizontal: 10.h),
              //         child: Column(
              //           mainAxisAlignment:
              //           MainAxisAlignment.center,
              //           crossAxisAlignment:
              //           CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               height: 40.v,
              //               width: 40.h,
              //               decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: appTheme.whiteA700
              //               ),
              //               child: Padding(
              //                 padding:  EdgeInsets.all(10.h),
              //                 child: CustomImageView(
              //                   imagePath: model.icon,
              //                   height: 24.adaptSize,
              //                   width: 24.adaptSize,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 10.v,
              //             ),
              //             Text(model.title!,
              //                 maxLines: 1,
              //                 textAlign: TextAlign.center,
              //                 style: CustomTextStyles
              //                     .bodyMediumOnErrorContainer
              //                     .copyWith(
              //                     color: appTheme.black900)),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(height: 24.v),
              _buildDetails(),
              SizedBox(height: 5.v),
            ],
          ),
        ),
       // bottomNavigationBar: buildButtons(),
      ),
    );
  }



  /// Section Widget
  Widget _buildDetails() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 17.v,
        ),
        decoration: AppDecoration.fillGray.copyWith(
          color: appTheme.textfieldFillColor,
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBookingCode(
              bookingCode: "lbl_ground".tr,
              gR: historyUpcomingModel.subGround??"",
            ),
            SizedBox(height: 20.v),
            _buildBookingCode(
              bookingCode: "lbl_booking_code".tr,
              gR: historyUpcomingModel.bookingCode??"",
            ),
            SizedBox(height: 18.v),
            _buildBookingCode(
              bookingCode: "lbl_date".tr,
              gR: historyUpcomingModel.date??"",
            ),
            SizedBox(height: 18.v),
            _buildBookingCode(
              bookingCode: "lbl_time".tr,
              gR: historyUpcomingModel.time??""
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget buildButtons() {
    return Container(
      width: double.infinity,
     color: appTheme.bgColor,
      child: Padding(
        padding:  EdgeInsets.only(top: 16.v,bottom: 32.v,left: 20.h,right: 20.h),
        child: CustomElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.writeAReviewScreen);
          },
          text: "lbl_write_a_review".tr,
        ),
      ),
    );
  }


  /// Common widget
  Widget _buildBookingCode({
    required String bookingCode,
    required String gR,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            bookingCode,
            style: CustomTextStyles.bodyLargeGray60001.copyWith(
              color: appTheme.gray60001,
            ),
          ),
        ),
        SizedBox(
          width: 200.h,
          child: Text(
            gR,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.titleMedium16.copyWith(
              color: appTheme.black900,
            ),
          ),
        ),
      ],
    );
  }
}





