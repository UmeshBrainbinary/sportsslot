import 'package:flutter/cupertino.dart';

import '../controller/events_controller.dart';
import '../models/events_item_model.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';

class EventsItemWidget extends StatelessWidget {
  EventsItemWidget(this.eventsItemModelObj, {Key? key}) : super(key: key);

  final EventsItemModel eventsItemModelObj;

  final controller = Get.find<EventsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.eventsDetailScreen,
          arguments: {
            "data" : eventsItemModelObj,
          }
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: AppDecoration.fillGray.copyWith(
          color: appTheme.boxWhite,
          borderRadius: BorderRadiusStyle.roundedBorder16,
          border: Border.all(color: appTheme.boxBorder)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: eventsItemModelObj.image?[0],
              child: CustomImageView(
                  imagePath: eventsItemModelObj.image?[0],
                  height: 163.v,
                  width: double.infinity,
                  radius: BorderRadius.circular(16.h),
                  alignment: Alignment.center),
            ),
            SizedBox(height: 9.v),
            Row(
              children: [
                Text(
                  eventsItemModelObj.tournamentName!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: appTheme.black900,
                      fontFamily: 'Montserrat-Medium'
                  ),
                ),
                // SizedBox(width: 10),
                // CustomElevatedButton(
                //   height: 29.v,
                //   width: 77.h,
                //   text: "lbl_explore".tr,
                //   buttonTextStyle: CustomTextStyles.bodyMediumPrimaryContainer,
                // ),
              ],
            ),
            SizedBox(height: 9.v),
            Text(
              eventsItemModelObj.date!,
              style: theme.textTheme.bodyMedium?.copyWith(fontFamily: 'Montserrat-Medium'),
            ),
            SizedBox(height: 9.v),

          ],
        ),
      ),
    );
  }
}
