import 'package:flutter/material.dart';

/// A controller class for the SearchScreen.
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/presentation/search_screen/models/search_model.dart';

///
/// This class manages the state of the SearchScreen, including the
/// current searchModelObj
class SearchControllers extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<SearchModel> searchModelList = [];
  List<GroundDetailListModel> searchRecentList = [];
  List<GroundDetailListModel> searchList = [];

  RxBool loader = false.obs;

 bool isFilter = false;

  void searching(value) {
    searchList = (searchRecentList.where((element) {
      return element.title
          .toString()
          .toLowerCase()
          .contains(value.toString().toLowerCase());
    }).toList()) ??
        [];

  update(["search"]);

  }
  @override
  void onClose() {
    super.onClose();
    searchController.clear();
  }
}
