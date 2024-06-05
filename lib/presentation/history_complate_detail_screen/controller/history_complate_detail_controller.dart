import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/history_complate_detail_screen/models/history_complate_detail_model.dart';

/// A controller class for the HistoryComplateDetailScreen.
///
/// This class manages the state of the HistoryComplateDetailScreen, including the
/// current historyComplateDetailModelObj
class HistoryComplateDetailController extends GetxController {
  Rx<HistoryComplateDetailModel> historyComplateDetailModelObj =
      HistoryComplateDetailModel().obs;
}
