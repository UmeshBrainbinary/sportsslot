
/// A controller class for the NearbyYouScreen.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/presentation/nearby_you_screen/models/nearby_you_model.dart';

import '../models/nearby_model_data.dart';

///
/// This class manages the state of the NearbyYouScreen, including the
/// current nearbyYouModelObj
class NearbyYouController extends GetxController {
  //List<NearbyYouModel> nearlyYoudata = NearbyYouData.getNearbyYouData();

 List<GroundDetailListModel> nearlyYoudata = [
  // {
  //  "image" : ImageConstant.imgFunnyStartsKi,
  //  "title" : "Jawaharlal Nehru Stadium.",
  //  "location" : "Delhi",
  //  "distance" : "",
  //  "latitude" : 21.1702,
  //  "longitude" : 72.8311,
  // },
  //
  // {
  //  "image" : ImageConstant.hockeyPlayerTournamentGround,
  //  "title" : "Feroz Shah Kotla Stadium.",
  //  "location" : "Surat",
  //  "distance" : "",
  //  "latitude" : 21.17502,
  //  "longitude" : 72.8911,
  // },
  //
  // {
  //  "image" : ImageConstant.soccerPlayerTournamentGroundWithPlayer,
  //  "title" : "Jawaharlal Nehru Stadium.",
  //  "location" : "Motavaracha, Surat",
  //  "distance" : "",
  //  "latitude" : 21.22502,
  //  "longitude" : 72.89911,
  // },
  //
  // {
  //  "image" : ImageConstant.hockeyPlayerTournamentGround,
  //  "title" : "Government sports stadium",
  //  "location" : "Delhi",
  //  "distance" : "",
  //  "latitude" : 22.3072,
  //  "longitude" : 73.1812,
  // },
  //
  // {
  //  "image" : ImageConstant.stadiumForRunning,
  //  "title" : "State sports stadium",
  //  "location" : "Gujarat",
  //  "distance" : "",
  //  "latitude" : 21.8000,
  //  "longitude" : 72.89911,
  // },
  //
  // {
  //  "image" : ImageConstant.stadiumBarcelonaFromHelicopter,
  //  "title" : "Ice Skating Rink, Sports College, Dehradun",
  //  "location" : "Dehradun",
  //  "distance" : "",
  //  "latitude" : 21.2252,
  //  "longitude" : 72.80,
  // },

 ];

}
