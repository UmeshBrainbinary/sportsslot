import 'package:sportsslot/core/app_export.dart';

class OneGroundDetailController extends GetxController {
  List<Map<String, dynamic>> facility = [
    {'image' : AssetRes.parkingIcon, 'title' : 'Parking'},
    {'image' : AssetRes.cameraIcon, 'title' : 'Camera'},
    {'image' : AssetRes.homeIcon, 'title' : 'Waiting room'},
    {'image' : AssetRes.changingRoomIcon, 'title' : 'Change room'},
  ];
}