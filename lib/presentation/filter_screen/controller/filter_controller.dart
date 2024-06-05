
/// A controller class for the FilterScreen.
import 'package:flutter/cupertino.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/filter_screen/models/filter_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/ground_type_model.dart';
import '../models/price_range_model.dart';

///
/// This class manages the state of the FilterScreen, including the
/// current filterModelObj
class FilterController extends GetxController {
 List<PriceRangeModel> priceList =  FilterModel.getPriceList();
 List<GroundTypeModel> groundList =  FilterModel.getGroundTypeDataList();
 int currentPrice = 1;
 int currentGroundType = 1;
 TextEditingController startRangeController = TextEditingController();
 TextEditingController endRangeController = TextEditingController();
 TextEditingController locationController = TextEditingController();

 LatLng? searchedLocation;

 List filteredData = [];

 String? categoryId ;



}
