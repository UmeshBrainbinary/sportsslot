import '../../../core/app_export.dart';
import 'popularground_item_model.dart';

/// This class defines the variables used in the [popular_ground_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PopularGroundModel {

  static List<PopulargroundItemModel> getPopularGroundData(){
    return [
      PopulargroundItemModel(ImageConstant.hockeyPlayerTournamentGround,"Hover ground", "Fairfield", false, false, true),
      PopulargroundItemModel(ImageConstant.indiraGandhiStadiumHaldwani,"Sport ground", "Banglore", false, true, true),
      PopulargroundItemModel(ImageConstant.soccerPlayerTournamentGround,"Futsal ground", "Fairfield",false, true,true),
      PopulargroundItemModel(ImageConstant.soccerPlayerTournamentGroundWithPlayer,"Unique blend each", "Viet nam", true, true, false),
      PopulargroundItemModel(ImageConstant.stadiumForRunning,"Unique blend each", "Viet nam", true, true, true),

    ];
  }

}
