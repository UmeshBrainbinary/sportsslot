import '../../../core/app_export.dart';
import 'events_item_model.dart';

/// This class defines the variables used in the [events_page],
/// and is typically used to hold data that is passed between different parts of the application.
class EventsModel {
  static List<EventsItemModel> getEventsData() {
    return [
      // EventsItemModel(
      //   ImageConstant.cricketImage,
      //   "IPL Match - Chennai Vs kolkata",
      //   "Rajiv gandhi international stadium",
      //   "",
      //   "14 April 2024",
      //   "₹2200",
      //   "15 April 2024",
      //   "6:30 PM - 11:30 PM",
      //   "₹2000",
      //   "Registration 15 April",
      //   [
      //     ImageConstant.cricketImage,
      //     ImageConstant.hockeyPlayerTournamentGround,
      //     ImageConstant.cricketImage,
      //     ImageConstant.imgRectangle40192,
      //   ],
      // ),
      // EventsItemModel(
      //   ImageConstant.imgRectangle34632791,
      //   "Football  Match - Uttarakhand Vs Madhya pradesh",
      //   "Rajiv gandhi international stadium",
      //   "",
      //   "10 May 2024",
      //   "₹2200",
      //   "12 May 2024",
      //   "4:30 PM - 9:30 PM",
      //   "₹2000",
      //   "Registration 12 May",
      //   [
      //     ImageConstant.imgRectangle40189,
      //     ImageConstant.imgRectangle40190,
      //     ImageConstant.imgRectangle40191,
      //     ImageConstant.imgRectangle40192,
      //     ImageConstant.imgRectangle40189,
      //   ],
      // ),
    ];
  }
}
