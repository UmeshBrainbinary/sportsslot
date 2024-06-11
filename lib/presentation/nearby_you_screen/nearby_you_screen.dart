// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/detail_screen/controller/detail_controller.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/presentation/detail_screen/models/ground_list_model.dart';
import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:geolocator/geolocator.dart';
import '../popular_ground_screen/controller/popular_ground_controller.dart';
import 'controller/nearby_you_controller.dart';
import 'models/nearby_you_model.dart';



class NearbyYouScreen extends StatefulWidget {
  const NearbyYouScreen({super.key});

  @override
  State<NearbyYouScreen> createState() => _NearbyYouScreenState();
}

class _NearbyYouScreenState extends State<NearbyYouScreen> {

 NearbyYouController controller = Get.put(NearbyYouController());
 PopularGroundController popularGroundController = Get.put(PopularGroundController());
 HomeController homeController = Get.put(HomeController(HomeModel().obs));
 DetailController detailController = Get.put(DetailController());

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return WillPopScope(
    onWillPop: ()async {
      Get.back();
      return true;
    },
    child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.bgColor,
        body: SafeArea(
          child: Column(
              children: [
           getCommonAppBar("lbl_nearby_you".tr),
           SizedBox(height: 16.v),
             Expanded(
              child:
               controller.nearlyYoudata.isNotEmpty
              ? ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: controller.nearlyYoudata.length,
                itemBuilder: (context, index) {


                  return FutureBuilder(
                      future: homeController.getLocationName(controller.nearlyYoudata[index].latitude.toDouble(), controller.nearlyYoudata[index].longitude.toDouble()),
                      builder: (context, cityName){
                        return animationfunction(index, Padding(
                          padding:  EdgeInsets.symmetric(vertical: 8.v),
                          child: GestureDetector(
                            onTap: (){




                              Get.toNamed(AppRoutes.detailScreen, arguments: {
                                "data" : controller.nearlyYoudata[index],
                              });


                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.h),
                                decoration: AppDecoration.fillGray.copyWith(
                                    color: appTheme.boxWhite,
                                    borderRadius: BorderRadiusStyle.roundedBorder16,
                                  border: Border.all(color: appTheme.boxBorder)
                                ),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      buildSeventeen(
                                          image: controller.nearlyYoudata[index].image[0],
                                          distance: controller.nearlyYoudata[index].km
                                      ),

                                      SizedBox(height: 12.v),
                                      Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                                          child: Text( controller.nearlyYoudata[index].title,
                                              style: theme.textTheme.titleMedium!.copyWith(
                                                  color: appTheme.black900
                                              ))),
                                      SizedBox(height: 5.v),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.h),
                                        child: Row(
                                          children: [
                                            CustomImageView(
                                              color: appTheme.black900,
                                              imagePath: ImageConstant.imgIcLocation,
                                              height: 20.adaptSize,
                                              width: 20.adaptSize,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.h),
                                              child: Text(
                                                  cityName.data.toString(),
                                                  style: theme.textTheme.bodyMedium!.copyWith(
                                                    color: appTheme.black900,
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16.v)
                                    ])),
                          ),
                        ));
                      }
                  );
                },)
                   : Center(
                     child: Text("no_data".tr,
                                      style: theme
                       .textTheme.displayMedium!
                       .copyWith(
                       color: appTheme
                           .buttonColor,
                       fontSize: 14)),
                   ),
            )

          ]),
        )),
  );
 }

 /// Common widget
 Widget buildSeventeen({
  required String image,
  required String distance,
 }) {
  return SizedBox(
      height: 163.v,
      width: double.infinity,
      child: Stack(alignment: Alignment.topRight, children: [
       Hero(
         tag: image,
         child: CustomImageView(
             imagePath: image,
             height: 163.v,
             width: double.infinity,
             radius: BorderRadius.circular(16.h),
             alignment: Alignment.center),
       ),
       Align(
           alignment: Alignment.topRight,
           child: Container(
               margin: EdgeInsets.only(top: 12.v, right: 12.h),
               padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
               decoration: AppDecoration.white
                   .copyWith(borderRadius: BorderRadiusStyle.circleBorder10),
               child: Text(distance,
                   style: theme.textTheme.bodySmall!.copyWith(
                       color: theme.colorScheme.onErrorContainer))))
      ]));
 }

 /// Navigates to the homeContainerScreen when the action is triggered.
 onTapNearbyYou() {
  Get.toNamed(
   AppRoutes.homeContainerScreen,

  );
 }
}





