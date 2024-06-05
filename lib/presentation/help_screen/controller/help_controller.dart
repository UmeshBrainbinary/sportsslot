import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/help_screen/models/help_item_modal.dart';
import 'package:sportsslot/presentation/help_screen/models/help_model.dart';

/// A controller class for the HelpScreen.
///
/// This class manages the state of the HelpScreen, including the
/// current helpModelObj
class HelpController extends GetxController {
  //RxList<HelpItemModal> helpModelObj = HelpModel.getHelpItem().obs;
  List<HelpItemModal> helpModelObj = [];

}
