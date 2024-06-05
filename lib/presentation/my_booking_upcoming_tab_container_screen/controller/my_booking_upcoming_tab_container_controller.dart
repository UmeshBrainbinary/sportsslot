import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/models/my_booking_upcoming_model.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_tab_container_screen/models/my_booking_upcoming_tab_container_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the MyBookingUpcomingTabContainerScreen.
///
/// This class manages the state of the MyBookingUpcomingTabContainerScreen, including the
/// current myBookingUpcomingTabContainerModelObj
class MyBookingUpcomingTabContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<MyBookingUpcomingTabContainerModel> myBookingUpcomingTabContainerModelObj =
      MyBookingUpcomingTabContainerModel().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 3));

  List<MyBookingUpcomingModel> getMyBookingUpcoming =  [];
  List<MyBookingUpcomingModel> getMyBookingRunning =  [];
  List<MyBookingUpcomingModel> getMyBookingUpCompleted =  [];
}
