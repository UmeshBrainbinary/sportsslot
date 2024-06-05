import 'package:flutter/cupertino.dart';
import 'package:sportsslot/core/app_export.dart';

import '../models/detail_model.dart';
import '../models/detailscreen_item_model.dart';
import '../models/ground_list_model.dart';


class DetailController extends GetxController {
  PageController pageController = PageController();
  int currentPage = 0;
  int currentGround = 0;
  int reviewListCount = 0;
  double averageReview = 0.0;

  List<DetailscreenItemModel> facilityList = [];
  List<GroundListModel> groundList = [];
  // String groundId

  List<GroundDetailListModel> groundDetailList = [];

  GroundListModel? selectGroundList ;



}
