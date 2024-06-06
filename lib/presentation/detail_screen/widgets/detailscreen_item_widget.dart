import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsslot/core/app_export.dart';
import '../controller/detail_controller.dart';
import '../models/ground_list_model.dart';

// ignore: must_be_immutable
class DetailscreenItemWidget extends StatelessWidget {
  DetailscreenItemWidget(
    this.detailscreenItemModelObj,
      this.index,
      {
    Key? key,
  }) : super(
          key: key,
        );

  GroundListModel detailscreenItemModelObj;
  int index;

  var controller = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DetailController>(
      init: DetailController(),
      builder: (controller) => GestureDetector(
        onTap: (){
          controller.currentGround = index;
          controller.update();
          controller.selectGroundList = detailscreenItemModelObj;
        },
        child: Container(
          padding: EdgeInsets.all(3.h),
          decoration: AppDecoration.outlinePrimary.copyWith(
            color: appTheme.textfieldFillColor,
            border: Border.all(
                color: controller.currentGround == index
                    ? appTheme.buttonColor
                    : Colors.transparent),
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          width: 118.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: (){
                  controller.currentGround = index;
                  controller.update();
                  controller.selectGroundList = detailscreenItemModelObj;

                  showDialog(
                   // barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          insetPadding: EdgeInsets.all(16.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.h)),
                          contentPadding: EdgeInsets.zero,
                          content: imageDialog(detailscreenItemModelObj.image??[]));
                    },
                  );
                },
                child: CustomImageView(
                  imagePath: detailscreenItemModelObj.image?[0],
                  height: 107.v,
                  width: 110.h,
                  radius: BorderRadius.circular(
                    16.h,
                  ),
                ),
              ),
              SizedBox(height: 10.v),

              SizedBox(
                width: 100.h,

                child: Text(
                  detailscreenItemModelObj.title!,
                  style: theme.textTheme.titleSmall?.copyWith( fontFamily: 'Montserrat-Medium',),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 6.v),
              Text(
                detailscreenItemModelObj.time!,
                style: theme.textTheme.bodyMedium?.copyWith( fontFamily: 'Montserrat-Medium',),
              ),
              SizedBox(height: 6.v),
              Text(
                "₹ ${detailscreenItemModelObj.price.toString()??""}/hour",
                style: theme.textTheme.bodyMedium?.copyWith( fontFamily: 'Montserrat-Medium',),
              ),
              SizedBox(height: 6.v),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageDialog(List images){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 22,
                width: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: PrefUtils().getThemeData() == "primary" ? appTheme.black : appTheme.white)
                ),
                child: Icon(
                    Icons.close,
                   size: 15,
                   color: PrefUtils().getThemeData() == "primary" ? appTheme.black : appTheme.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200.v,
            width: 600.h,
            child: PageView.builder(
              onPageChanged: (value) {
                controller.currentPage = value;
                controller.update();
              },
              controller: controller.pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Hero(
                  tag: images[index],
                  child: CustomImageView(
                    imagePath: images[index],
                    height: 220.v,
                    width: 400.h,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}
