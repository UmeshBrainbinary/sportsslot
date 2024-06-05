import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/notification_screen/models/notification_model.dart';

import '../models/notification_item_model.dart';

/// A controller class for the NotificationScreen.
///
/// This class manages the state of the NotificationScreen, including the
/// current notificationModelObj
class NotificationController extends GetxController {
 // List<NotificationItemModel> notificationDataList = NotificationModel.getNotificationData();

 List<NotificationItemModel> notificationDataList = [];

 String getTimeAgo(int minutesDifference) {
  // Logic to format time ago
  if (minutesDifference < 60) {
   return "$minutesDifference minute${minutesDifference == 1 ? '' : 's'} ago";
  } else {
   int hoursDifference = minutesDifference ~/ 60;
   return "$hoursDifference hour${hoursDifference == 1 ? '' : 's'} ago";
  }
 }

}
