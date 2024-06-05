import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/privacy_policy_screen/models/privacy_policy_item_modal.dart';
import 'package:sportsslot/presentation/privacy_policy_screen/models/privacy_policy_model.dart';

/// A controller class for the PrivacyPolicyScreen.
///
/// This class manages the state of the PrivacyPolicyScreen, including the
/// current privacyPolicyModelObj
class PrivacyPolicyController extends GetxController {
  RxList<PrivacyPolicyItemModal> privacyPolicyModelObj = PrivacyPolicyModel.getPolicyData().obs;

  RxString data = "".obs;
}
