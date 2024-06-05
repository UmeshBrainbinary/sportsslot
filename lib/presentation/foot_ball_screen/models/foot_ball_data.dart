import 'package:sportsslot/core/app_export.dart';

import 'foot_ball_model.dart';

class FootBallData{
  static List<FootBallModel> getFootBollData(){
    return [
      FootBallModel(ImageConstant.soccerPlayerTournamentGround, "Raj sports stadium", "Rudrapur., Udham Singh Nagar","2 KM"),
      FootBallModel(ImageConstant.soccerPlayerTournamentGroundWithPlayer, "State sports stadium.", "Manera, Uttarkashi","12 KM"),
      FootBallModel(ImageConstant.stadiumBarcelonaFromHelicopter, "Government sports stadium.", "Tanakpur, Champawat","8 KM"),
    ];
  }
}