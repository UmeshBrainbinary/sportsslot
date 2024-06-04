

import 'package:get/get.dart';

class DashboardController extends GetxController{
  final List items = [
    'Sports & Icon',
    'Stadium Details',
    'Event Details',
    "bookingHistory".tr,
    'notification'.tr,
    "privacyPolicy".tr,
    "faqs".tr,
    "lbl_about_us".tr,
    "Change Mode"
  ];

  RxInt currentIndex = 0.obs;
  RxBool isDarkTheme = false.obs;
}