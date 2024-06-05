import 'dart:convert';

import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/detail_screen/controller/detail_controller.dart';
import 'package:sportsslot/presentation/review_screen/models/review_model.dart';

import '../models/review_item_model.dart';

/// A controller class for the ReviewScreen.
///
/// This class manages the state of the ReviewScreen, including the
/// current reviewModelObj
class ReviewController extends GetxController {

 DetailController detailController = Get.find<DetailController>();

 String stadiumId = "";

 bool isDisable = false;

 @override
 void onInit() {
  // TODO: implement onInit

  super.onInit();
 }


 saveReview () async {

  if(PrefUtils.getString("reviews").isNotEmpty) {
   allReview = jsonDecode(PrefUtils.getString("reviews"));
  }

  await PrefUtils.setValue("reviews", jsonEncode(allReview));

  allReview = jsonDecode(PrefUtils.getString("reviews"));

  for(int i = 0; i < allReview.length; i++) {
   averageReview += double.parse(allReview[i]["star"]);
  }

  averageReview = averageReview / allReview.length;

  detailController.update();

  print(allReview);
  print(averageReview);
 }

 double averageReview = 0.0;


 List<ReviewItemModel> reviewList = ReviewModel.getReviewList();


 List<dynamic> allReview = [];

 String getTimeAgo(int minutesDifference) {
  // Logic to format time ago
  if (minutesDifference < 60) {
   return "$minutesDifference minute${minutesDifference == 1 ? '' : 's'} ago";
  } else {
   int hoursDifference = minutesDifference ~/ 60;
   return "$hoursDifference hour${hoursDifference == 1 ? '' : 's'} ago";
  }
 }


}
