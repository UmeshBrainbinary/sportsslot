import '../../../core/app_export.dart';
import 'detailscreen_item_model.dart';
import 'ground_list_model.dart';

/// This class defines the variables used in the [detail_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class DetailModel {



  static List<DetailscreenItemModel> getFacilityList(){
    return [
      DetailscreenItemModel( ImageConstant.imgParkingIcon,"Parking"),
      DetailscreenItemModel( ImageConstant.imgCameraIcon,"Camera"),
      DetailscreenItemModel( ImageConstant.imgWaaitingRoomIcon,"Waiting room"),
      DetailscreenItemModel( ImageConstant.imgChangingRoomIcon,"Change room"),
    ];
  }

  static List<GroundListModel> getGroundList(){
    return [
      // GroundListModel("", ImageConstant.imgRectangle3463281,"Main ground","3 Hour", 34, []),
      // GroundListModel("", ImageConstant.imgRectangle3463281107x110,"Futsal Ground","1 Hour", 45, []),
      // GroundListModel("", ImageConstant.imgRectangle34632811,"Tenis ground","2 Hour", 43, []),
    ];
  }

}


class GroundDetailListModel {
  String stadiumId;
  List image;
  String km;
  double latitude;
  double longitude;
  String price;
  String title;
  String description;
  List<DetailscreenItemModel> getFacilityList;
  List<GroundListModel> getGroundList;
  List features;
  List review;
  List categoryId;
  // String userId;
  // List subGroundIdList;

  GroundDetailListModel(
      { required this.stadiumId,
        required this.image,
        required this.km,
        required this.latitude,
        required this.longitude,
        required this.price,
      required this.title,
        required this.description,
        required this.getFacilityList,
        required this.getGroundList,
        required this.features,
        required this.review,
        required this.categoryId,
        // required this.userId,
        // required this.subGroundIdList
      });
}
