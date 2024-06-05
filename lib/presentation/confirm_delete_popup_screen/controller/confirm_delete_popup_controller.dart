import 'package:sportsslot/core/app_export.dart';import 'package:sportsslot/presentation/confirm_delete_popup_screen/models/confirm_delete_popup_model.dart';/// A controller class for the ConfirmDeletePopupScreen.
///
/// This class manages the state of the ConfirmDeletePopupScreen, including the
/// current confirmDeletePopupModelObj
class ConfirmDeletePopupController extends GetxController {Rx<ConfirmDeletePopupModel> confirmDeletePopupModelObj = ConfirmDeletePopupModel().obs;
RxBool loader = false.obs;
 }
