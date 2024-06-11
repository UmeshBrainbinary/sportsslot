
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:intl/intl.dart';
import 'controller/my_booking_upcoming_controller.dart';
import 'models/my_booking_upcoming_model.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

class MyBookingUpcomingPage extends StatefulWidget {
  List<MyBookingUpcomingModel> getMyBookingUpcoming;
  MyBookingUpcomingPage({Key? key, required this.getMyBookingUpcoming}) : super(key: key);

  @override
  State<MyBookingUpcomingPage> createState() => _MyBookingUpcomingPageState();
}

class _MyBookingUpcomingPageState extends State<MyBookingUpcomingPage> {

  MyBookingUpcomingController controller = Get.put(MyBookingUpcomingController());
  HomeController homeController = Get.put(HomeController(HomeModel().obs));

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return widget.getMyBookingUpcoming.isNotEmpty
    ? ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 4.v),
      itemCount: widget.getMyBookingUpcoming.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {


        MyBookingUpcomingModel data =  widget.getMyBookingUpcoming[index];


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
                      padding: EdgeInsets.all(8.h),
                      decoration: AppDecoration.fillGray.copyWith(
                        color: appTheme.boxWhite,
                        borderRadius: BorderRadiusStyle.roundedBorder16,
                        border: Border.all(color: appTheme.boxBorder)
                      ),
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: data.image,
                            height: 110.adaptSize,
                            width: 110.adaptSize,
                            radius: BorderRadius.circular(
                              16.h,
                            ),
                            margin: EdgeInsets.only(top: 2.v),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            SizedBox(
                            width: 250.h,
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
                                    width: 120.h,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.h),
                                      child: Text(
                                        cityName.data.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 9.v),
                              Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgIcBooking,
                                    height: 20.adaptSize,
                                    width: 20.adaptSize,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    data.registerDateTime??"",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              //Text(data.selectedDate??""),
                            ],
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
