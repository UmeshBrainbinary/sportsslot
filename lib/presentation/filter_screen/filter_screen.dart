import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/search_screen/controller/search_controller.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_outlined_button.dart';
import 'package:sportsslot/widgets/custom_text_form_field.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../../widgets/custom_search_view.dart';
import '../categories_screen/controller/categories_controller.dart';
import '../categories_screen/models/categories_item_model.dart';
import '../categories_screen/widgets/categories_item_widget.dart';
import 'controller/filter_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';


class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  FilterController controller = Get.put(FilterController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  SearchControllers searchController = Get.put(SearchControllers());

  FocusNode focusStart = FocusNode();
  FocusNode focusEnd = FocusNode();


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: ()async {
        Get.back();
        return true;
      },
      child: Scaffold(
          backgroundColor: appTheme.bgColor,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: GetBuilder<FilterController>(
              init: FilterController(),
              builder: (controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    getCommonAppBar("lbl_filter".tr,
                      actionwidget: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                            onTap: (){
                              controller.categoryId = null;
                              controller.startRangeController.clear();
                              controller.endRangeController.clear();
                              controller.locationController.clear();
                              controller.searchedLocation = null;
                              controller.update();
                            },
                            child: Icon(Icons.refresh, color: appTheme.black900)),
                      ),
                    ),
                    SizedBox(height: 20.v),
                   Expanded(child:  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: EdgeInsets.only(left: 20.h, right: 20.h),
                         child: getViewAllRow("sportIcon".tr, () {
                           Get.toNamed(AppRoutes.categoriesScreen, arguments: {
                             "isFilter" : true
                           });
                         }),
                       ),
                       SizedBox(height: 16.v),


                        SizedBox(
                          height: 50.v,
                          child: Padding(
                                            padding: EdgeInsets.only(left: 20.h, right: 20.h),
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: categoriesController.categoriesData.length,
                                                itemBuilder: (context, index){

                                                  CategoriesItemModel model =
                                                  categoriesController.categoriesData[index];

                          return animationfunction(
                              index,
                              index < 4
                                  ? CategoriesItemWidget(model,
                                  isFilter: true,
                                  onTapFootball: () {
                                    controller.categoryId = categoriesController.categoriesData[index].id;
                                    controller.update();
                                  })
                                  : SizedBox());
                                                }),
                                          ),
                        ),
                       SizedBox(height: 28.v),
                       Align(
                           alignment: Alignment.centerLeft,
                           child: Padding(
                               padding: EdgeInsets.only(left: 20.h),
                               child: Text("lbl_price_range".tr,
                                   style: theme.textTheme.titleLarge!.copyWith(
                                     color: appTheme.black900,fontFamily: 'Montserrat-Medium'
                                   )))),
                       SizedBox(height: 17.v),
                       Padding(
                           padding: EdgeInsets.symmetric(horizontal: 20.h),
                           child: CustomTextFormField(
                               focusNode: FocusNode(),
                               controller: controller.startRangeController,
                               textInputType: TextInputType.number,
                               filled: true,
                               hintText: "Enter start range",
                             inputFormatters: <TextInputFormatter>[
                               FilteringTextInputFormatter.digitsOnly
                             ],
                           )
                       ),
                       SizedBox(height: 18.v),
                       Padding(
                           padding: EdgeInsets.symmetric(horizontal: 20.h),
                           child: CustomTextFormField(

                             focusNode: FocusNode(),
                             controller: controller.endRangeController,
                             textInputType: TextInputType.number,
                             filled: true,
                             hintText: "Enter end range",
                             inputFormatters: <TextInputFormatter>[
                               FilteringTextInputFormatter.digitsOnly
                             ],
                           )
                       ),
                       SizedBox(height: 28.v),
                       Align(
                           alignment: Alignment.centerLeft,
                           child: Padding(
                               padding: EdgeInsets.only(left: 20.h),
                               child: Text("lbl_location2".tr,
                                   style: theme.textTheme.titleLarge!.copyWith(
                                     color: appTheme.black900,fontFamily: 'Montserrat-Medium'
                                   )))),
                       SizedBox(height: 17.v),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: 20.h),
                         child: GooglePlaceAutoCompleteTextField(
                           textEditingController: controller.locationController,
                           googleAPIKey: "AIzaSyDtFavTh7_aJL9D3XGEmoFlIImXsibuREY",

                           inputDecoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: "Enter location",
                           ),

                           debounceTime: 800 ,
                           countries: ["in","fr"],
                           isLatLngRequired:true,
                           getPlaceDetailWithLatLng: (Prediction prediction) {

                             print("placeDetails" + prediction.lng.toString());

                             double lat = double.parse(prediction.lat??"0.0");
                             double lng = double.parse(prediction.lng??"0.0");

                             controller.searchedLocation = LatLng(lat, lng);

                           },
                           itemClick: (Prediction prediction) {

                             FocusScope.of(context).unfocus();
                             controller.locationController.text = prediction.description??"";
                             controller.locationController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length??0));

                           },

                           itemBuilder: (context, index, Prediction prediction) {
                             return Container(
                               padding: EdgeInsets.all(10),
                               child: Row(
                                 children: [
                                   Icon(Icons.location_on),
                                   SizedBox(
                                       width: 7
                                   ),
                                   Expanded(child: Text("${prediction.description??""}"))
                                 ],
                               ),
                             );
                           },

                           seperatedBuilder: Divider(),

                           isCrossBtnShown: true,

                           containerHorizontalPadding: 10,

                         ),
                       ),
                     ],
                   ),),

                  ]),
            ),
          ),
          bottomNavigationBar: buildButtons()),
    );
  }


  /// Section Widget
  Widget buildReset() {
    return Expanded(
        child: CustomOutlinedButton(
            text: "lbl_reset".tr,
            margin: EdgeInsets.only(right: 8.h),
            onPressed: () {
              controller.categoryId = null;
              controller.startRangeController.clear();
              controller.endRangeController.clear();
              controller.locationController.clear();
              controller.searchedLocation = null;
              controller.update();
            }));
  }

  /// Section Widget
  Widget buildApply() {
    return Obx(() => CustomElevatedButton(
        text: "lbl_apply".tr,
        margin: EdgeInsets.only(left: 8.h),
        onPressed: searchController.loader.value ? (){} : () async{
          searchController.loader.value = true;

          searchController.isFilter = true;

          searchController.searchList = [];
          searchController.update(["search"]);
          ///






          if(controller.startRangeController.text.isNotEmpty && controller.endRangeController.text.isEmpty){
            errorToast("Enter end range");
          } else if (controller.endRangeController.text.isNotEmpty && controller.startRangeController.text.isEmpty){
            errorToast("Enter start range");
          } else{

            for(var data in  searchController.searchRecentList){

              Location searchLocation = Location(latitude: controller.searchedLocation?.latitude ??0.0, longitude: controller.searchedLocation?.longitude??0.0, timestamp: DateTime.now());
              Location dataLocation = Location(latitude: data.latitude, longitude: data.longitude, timestamp: DateTime.now());

              double threshold = 15000;

              double distance = calculateDistance(searchLocation, dataLocation);

              bool isPrice = false;

              for(var data2 in data.getGroundList){
                if((controller.startRangeController.text.isNotEmpty && controller.endRangeController.text.isNotEmpty)
                    && data2.price >= int.parse(controller.startRangeController.text)
                    && data2.price <= int.parse(controller.endRangeController.text)){
                  isPrice = true;
                }
              }
              /// ------------- all -----------


              if(controller.categoryId != null
                  && (controller.startRangeController.text.isNotEmpty && controller.endRangeController.text.isNotEmpty)
                  && controller.locationController.text.isNotEmpty){

                if(isPrice && data.categoryId.contains(controller.categoryId) && (distance <= threshold)){
                  searchController.searchList.add(data);
                  searchController.update(["search"]);
                }
              } else if(controller.categoryId != null
                  && (controller.startRangeController.text.isNotEmpty && controller.endRangeController.text.isNotEmpty)){

                if(isPrice && data.categoryId.contains(controller.categoryId)){
                  searchController.searchList.add(data);
                  searchController.update(["search"]);

                }
              } else if(controller.categoryId != null
                  && controller.locationController.text.isNotEmpty){
                if(data.categoryId.contains(controller.categoryId) && (distance <= threshold)){
                  searchController.searchList.add(data);
                  searchController.update(["search"]);
                }
              } else if((controller.startRangeController.text.isNotEmpty && controller.endRangeController.text.isNotEmpty)
                     && controller.locationController.text.isNotEmpty){
                if(isPrice  && (distance <= threshold)){
                  searchController.searchList.add(data);
                  searchController.update(["search"]);
                }
              } else if(controller.categoryId != null){
                if(data.categoryId.contains(controller.categoryId)){
                  searchController.searchList.add(data);
                  searchController.update(["search"]);
                }
              } else if(controller.startRangeController.text.isNotEmpty && controller.endRangeController.text.isNotEmpty){
                if(isPrice){
                  searchController.searchList.add(data);
                  searchController.update(["search"]);
                }
              } else if(controller.locationController.text.isNotEmpty){
                if((distance <= threshold)){
                  searchController.searchList.add(data);
                  searchController.update(["search"]);
                }
              } else{

              }

              /// - ------------ all end -----------

              // /// for price filter
              // if(isPrice){
              //
              //   searchController.searchList.add(data);
              //   searchController.update(["search"]);
              //
              //   searchController.searchList = searchController.searchList.fold([], (accumulator, currentMap) {
              //     if (!accumulator.any((map) => map.stadiumId == currentMap.stadiumId)) {
              //       accumulator.add(currentMap);
              //     }
              //     return accumulator;
              //   });
              //
              // }
              //
              // /// for category filter
              // if((controller.categoryId != null) && data.categoryId.contains(controller.categoryId)){
              //
              //   searchController.searchList.add(data);
              //   searchController.update(["search"]);
              //
              //   searchController.searchList = searchController.searchList.fold([], (accumulator, currentMap) {
              //     if (!accumulator.any((map) => map.stadiumId == currentMap.stadiumId)) {
              //       accumulator.add(currentMap);
              //     }
              //     return accumulator;
              //   });
              //
              // }
              //
              // /// for location filter
              // if(controller.locationController.text.isNotEmpty && (distance <= threshold)){
              //
              //   searchController.searchList.add(data);
              //   searchController.update(["search"]);
              //
              //   searchController.searchList = searchController.searchList.fold([], (accumulator, currentMap) {
              //     if (!accumulator.any((map) => map.stadiumId == currentMap.stadiumId)) {
              //       accumulator.add(currentMap);
              //     }
              //     return accumulator;
              //   });
              //
              // }

            }
          }




          ///
          searchController.loader.value = false;
          searchController.searchController.clear();
          //Get.offAllNamed(AppRoutes.searchScreen);
          Get.back();

        }));
  }

  double calculateDistance(Location location1, Location location2) {
    const double earthRadius = 6371000; // in meters

    double lat1 = location1.latitude * pi / 180;
    double lon1 = location1.longitude * pi / 180;
    double lat2 = location2.latitude * pi / 180;
    double lon2 = location2.longitude * pi / 180;

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  /// Section Widget
  Widget buildButtons() {
    return Container(
      width: double.infinity,
        color: appTheme.bgColor,
        padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 32.v,top: 16.v),
        child: buildApply()
    );
  }



  /// Navigates to the categoriesScreen when the action is triggered.
  onTapTxtViewAll() {
    Get.toNamed(
      AppRoutes.categoriesScreen,
    );
  }

  /// Navigates to the homeContainerScreen when the action is triggered.
  onTapReset() {
    Get.toNamed(
      AppRoutes.homeContainerScreen,
    );
  }

  /// Navigates to the homeContainerScreen when the action is triggered.
  onTapApply() {
    Get.toNamed(
      AppRoutes.homeContainerScreen,
    );
  }
}
