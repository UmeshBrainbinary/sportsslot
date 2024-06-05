import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/write_a_review_screen/models/write_a_review_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the WriteAReviewScreen.
///
/// This class manages the state of the WriteAReviewScreen, including the
/// current writeAReviewModelObj
class WriteAReviewController extends GetxController {
  TextEditingController reviewController = TextEditingController();

  Rx<WriteAReviewModel> writeAReviewModelObj = WriteAReviewModel().obs;

  double rating = 0.0;

  RxBool loader = false.obs;

  @override
  void onClose() {
    super.onClose();
    reviewController.dispose();
  }
}
