import '../controller/review_controller.dart';
import '../models/review_item_model.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

// ignore: must_be_immutable
class ReviewItemWidget extends StatelessWidget {
  ReviewItemWidget({Key? key, required this.data,}) : super(key: key);

  final Map data;

  var controller = Get.find<ReviewController>();

  @override
  Widget build(BuildContext context) {

    Duration difference = DateTime.now().difference(data["time"].toDate());
    int minutesDifference = difference.inMinutes.abs();

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgAvtar1,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                    radius: BorderRadius.circular(
                      20.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.h,
                      top: 13.v,
                      bottom: 6.v,
                    ),
                    child: Text(
                      data["name"],
                      style: CustomTextStyles.titleMedium16!.copyWith(
                          color:appTheme.black900
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.h,
                      top: 13.v,
                      bottom: 6.v,
                    ),
                    child: Text(
                      minutesDifference == 0 ? "Just now" : controller.getTimeAgo(minutesDifference),
                      style: CustomTextStyles.bodyLargeGray60001,
                    ),
                  ),
                ],
              ),


             Row(
               children: [
                 CustomImageView(
                   imagePath: ImageConstant.imgIcStar,
                   height: 24.adaptSize,
                   width: 24.adaptSize,
                 ),
                 Padding(
                   padding: EdgeInsets.only(
                     left: 2.h,
                     top: 10.v,
                     bottom: 9.v,
                   ),
                   child: Text(
                     data["star"].toString(),
                     style: theme.textTheme.bodyLarge!.copyWith(
                         color:appTheme.black900
                     ),
                   ),
                 ),
               ],
             )
            ],
          ),
          SizedBox(height: 10.v),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 11.h),
            child:  Text(
              data["review"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: appTheme.black900,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
