import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/my_booking_complated_page/models/my_booking_complated_model.dart';

import '../models/my_booking_completed_data.dart';

/// A controller class for the MyBookingComplatedPage.
///
/// This class manages the state of the MyBookingComplatedPage, including the
/// current myBookingComplatedModelObj
class MyBookingComplatedController extends GetxController {
  List<MyBookingComplatedModel> getMybookingComplated = MyBookingCompletedData.getMyBookingCompletedData();
}
