
/// A controller class for the BookingDetailsScreen.
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/booking_details_screen/models/booking_details_model.dart';
import 'package:sportsslot/presentation/my_booking_upcoming_page/models/my_booking_upcoming_model.dart';

import '../models/notify_me_data.dart';

///
/// This class manages the state of the BookingDetailsScreen, including the
/// current bookingDetailsModelObj
class BookingDetailsController extends GetxController {
 List<BookingDetailsModel> notifyMeList = NotifyMeData.getNotifyData();

 late MyBookingUpcomingModel data;
 String location = "";
}
