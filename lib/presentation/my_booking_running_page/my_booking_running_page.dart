import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/controller/my_booking_upcoming_controller.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/models/my_booking_upcoming_model.dart';
import 'package:intl/intl.dart';


import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

class MyBookingRunningPage extends StatefulWidget {
  List<MyBookingUpcomingModel> getMyBookingRunning;
  MyBookingRunningPage({Key? key, required this.getMyBookingRunning}) : super(key: key);

  @override
  State<MyBookingRunningPage> createState() => _MyBookingRunningPageState();
}

class _MyBookingRunningPageState extends State<MyBookingRunningPage> {
  MyBookingUpcomingController controller = Get.put(MyBookingUpcomingController());
  HomeController homeController = Get.put(HomeController(HomeModel().obs));

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return widget.getMyBookingRunning.isNotEmpty
        ? ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 4.v),
      itemCount: widget.getMyBookingRunning.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {


        MyBookingUpcomingModel data =  widget.getMyBookingRunning[index];


        return FutureBuilder(
            future: homeController.getLocationName(data.latitude, data.longitude),
            builder: (context, cityName){
              return animationfunction(index, Padding(
                padding:  EdgeInsets.symmetric(vertical: 8.v),
                child: GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.bookingDetailsScreen, arguments: {
                      "data" : data,
                      "location": cityName.data.toString()
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.h),
                    decoration: AppDecoration.fillGray.copyWith(
                      color: appTheme.boxWhite,
                      border: Border.all(color: appTheme.boxBorder),
                      borderRadius: BorderRadiusStyle.roundedBorder16,
                    ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: data.image,
                          height: 90.adaptSize,
                          width: 90.adaptSize,
                          radius: BorderRadius.circular(
                            16.h,
                          ),
                          margin: EdgeInsets.only(top: 2.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.h,
                            top: 23.v,
                            bottom: 17.v,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 260.h,
                                child: Text(
                                  data.title??"",
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium!.copyWith(
                                    color: appTheme.black900,
                                  ),
                                ),
                              ),
                              SizedBox(height: 9.v),
                              Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgIcLocationGray60001,
                                    height: 20.adaptSize,
                                    width: 20.adaptSize,
                                  ),
                                  SizedBox(
                                    width: 70.h,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.h),
                                      child: Text(
                                        cityName.data.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgIcBooking,
                                    height: 20.adaptSize,
                                    width: 20.adaptSize,
                                    margin: EdgeInsets.only(left: 16.h),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 8.h,
                                      top: 2.v,
                                    ),
                                    child: Text(
                                      data.registerDateTime??"",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                              //Text(data.selectedDate??""),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            }
        );


      },)
        :  Center(
      child: Text("no_data_found".tr,
          style: theme
              .textTheme.displayMedium!
              .copyWith(
              color: appTheme
                  .buttonColor,
              fontSize: 14)),
    );
  }

}
