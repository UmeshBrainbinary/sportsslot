import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

class EventsdetailItemWidget extends StatelessWidget {
  EventsdetailItemWidget({Key? key, required this.previousMemory, required this.index})
      : super(key: key);

  final List previousMemory;
  final int index;

  // EventsDetailController controller = Get.put(EventsDetailController());

  // var eventsDetailController = Get.find<EventsDetailController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Container(
              child: CustomImageView(
                imagePath: previousMemory[index],
                height: double.infinity,
                width: double.infinity,
              ),
            );
          },
          child: CustomImageView(
            imagePath: previousMemory[index],
            height: double.infinity,
            width: double.infinity,
            radius: BorderRadius.only(
              topLeft: Radius.circular(index == 3 ? 0 : 16.h),
              topRight: Radius.circular(index == 2 ? 0 : 16.h),
              bottomLeft: Radius.circular(index == 1 ? 0 : 16.h),
              bottomRight: Radius.circular(index == 0 ? 0 : 16.h),
            ),
          ),
        ),
        index == 3 && previousMemory.length > 4
            ? Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.60),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 3 ? 0 : 16.h),
                    topRight: Radius.circular(index == 2 ? 0 : 16.h),
                    bottomLeft: Radius.circular(index == 1 ? 0 : 16.h),
                    bottomRight: Radius.circular(index == 0 ? 0 : 16.h),
                  ),
                ),
                child: Center(
                    child: Text(
                  "+${previousMemory.length - 4} Posts",
                  style: TextStyle(color: appTheme.whiteA700, fontSize: 20.fSize),
                )),
              )
            : SizedBox()
      ],
    );
  }
}