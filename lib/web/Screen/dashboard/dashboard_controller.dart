

import 'package:get/get.dart';

class DashboardController extends GetxController {

  final List items = [
    'Sports',
    "bookingHistory".tr,
    'Event',
    'Stadium',
    // 'notification'.tr,
    // "privacyPolicy".tr,
    // "faqs".tr,
    // "lbl_about_us".tr,
    "lbl_legals".tr,
    "lbl_settings".tr,
  ];

  RxInt currentIndex = 0.obs;
  RxBool isDarkTheme = false.obs;
}