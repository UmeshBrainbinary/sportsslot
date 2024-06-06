import 'package:flutter/material.dart' hide SearchController;
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:sportsslot/widgets/custom_icon_button.dart';
import 'package:sportsslot/widgets/custom_search_view.dart';
import 'controller/search_controller.dart';
import 'models/search_model.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

 SearchControllers searchControllers = Get.put(SearchControllers());
 HomeController homeController = Get.put(HomeController(HomeModel().obs));

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return Scaffold(
   backgroundColor: appTheme.bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:

        /// old search UI(RECENT SEARCH)
        // SizedBox(
        //     width: double.maxFinite,
        //     child: GetBuilder<SearchControllers>(
        //       init: SearchControllers(),
        //       builder:(controller) =>  Column(children: [
        //    getCommonAppBar("lbl_search".tr),
        //        SizedBox(height: 16.v),
        //         Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 20.h),
        //             child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //               Expanded(
        //                   child: CustomSearchView(
        //                     onFieldSubmitted: (p0) {
        //                       controller.searchModelList.add(SearchModel(p0));
        //                       controller.searchController.clear();
        //                       controller.update();
        //                     },
        //                       controller: controller.searchController,
        //                       onChanged: (value){
        //
        //                       },
        //                       hintText: "lbl_search".tr)),
        //               Padding(
        //                   padding: EdgeInsets.only(left: 16.h),
        //                   child: CustomIconButton(
        //                       height: 56.adaptSize,
        //                       width: 56.adaptSize,
        //                       padding: EdgeInsets.all(16.h),
        //                       decoration: IconButtonStyleHelper.fillPrimary,
        //                       onTap: () {
        //                         onTapBtnIconButton();
        //                       },
        //                       child: CustomImageView(
        //                           imagePath: ImageConstant.imgGroup1171275017)))
        //             ])),
        //        SizedBox(height: 27.v),
        //        Align(
        //            alignment: Alignment.centerLeft,
        //            child: Padding(
        //                padding: EdgeInsets.only(left: 20.h),
        //                child: Text("lbl_recent".tr,
        //                    style: theme.textTheme.titleLarge!.copyWith(
        //                         color: appTheme.black900,
        //                    )))),
        //        SizedBox(height: 18.v),
        //
        //        ListView.builder(
        //          padding: EdgeInsets.only(left: 20.h, right: 20.h),
        //          primary: false,
        //          shrinkWrap: true,
        //          itemCount: controller.searchModelList.length,
        //          itemBuilder: (context, index) {
        //           SearchModel searchModel = controller.searchModelList[index];
        //
        //
        //
        //
        //          return Padding(
        //            padding:  EdgeInsets.symmetric(vertical: 12.v),
        //            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //              CustomImageView(
        //                  imagePath: ImageConstant.imgIcSearch,
        //                  height: 24.adaptSize,
        //                  width: 24.adaptSize),
        //              Padding(
        //                  padding: EdgeInsets.only(left: 16.h, top: 3.v),
        //                  child: Text(searchModel.searchMessege!,
        //                      style: theme.textTheme.bodyLarge!
        //                          .copyWith(color: appTheme.black900))),
        //              Spacer(),
        //              InkWell(
        //                onTap: () {
        //                  controller.searchModelList.removeAt(index);
        //                  controller.update();
        //                },
        //                child: CustomImageView(
        //
        //                    color: appTheme.black900,
        //                    imagePath: ImageConstant.imgIcCancel,
        //                    height: 24.adaptSize,
        //                    width: 24.adaptSize),
        //              )
        //            ]),
        //          );
        //        },),
        //        SizedBox(height: 40.v),
        //        GestureDetector(
        //          onTap: (){
        //            controller.searchModelList.clear();
        //             controller.update();
        //          },
        //          child: Text("lbl_clear_all".tr,
        //              style: CustomTextStyles.titleMediumPrimaryBold),
        //        ),
        //        SizedBox(height: 5.v)
        //       ]),
        //     )),

        /// NEW Ui Static logic
       Stack(
         children: [
           SizedBox(
               width: double.maxFinite,
               child: GetBuilder<SearchControllers>(
                 id: "search",
                 init: SearchControllers(),
                 builder:(controller) =>  Column(
                     children: [
                   getCommonAppBar("lbl_search".tr),
                   SizedBox(height: 16.v),
                   Padding(
                       padding: EdgeInsets.symmetric(horizontal: 20.h),
                       child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Expanded(
                               child:
                               SizedBox(
                                 width:  double.maxFinite,
                                 child: TextFormField(

                                   controller: controller.searchController,

                                   onChanged: (value){


                                     controller.searching(value);


                                   },
                                   style: theme.textTheme.bodyLarge!.copyWith(
                                     color: appTheme.black900,
                                       fontFamily: 'Montserrat-Medium'
                                   ),

                                   maxLines:  1,
                                   decoration: InputDecoration(
                                     hintText: "lbl_search".tr,
                                     hintStyle:  CustomTextStyles.bodyLargeGray60001,
                                     prefixIcon:
                                     Container(
                                       margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                                       child: CustomImageView(
                                         imagePath: ImageConstant.imgIcSearch,
                                         height: 24.adaptSize,
                                         width: 24.adaptSize,
                                       ),
                                     ),
                                     prefixIconConstraints:
                                     BoxConstraints(
                                       maxHeight: 56.v,
                                     ),

                                     suffixIconConstraints:
                                     BoxConstraints(
                                       maxHeight: 56.v,
                                     ),
                                     isDense: true,
                                     contentPadding:
                                     EdgeInsets.only(
                                       top: 18.v,
                                       right: 18.h,
                                       bottom: 18.v,
                                     ),
                                     fillColor:  appTheme.textfieldFillColor,
                                     filled: true,
                                     border:
                                     OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(16.h),
                                       borderSide: BorderSide.none,
                                     ),
                                     enabledBorder:
                                     OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(16.h),
                                       borderSide: BorderSide.none,
                                     ),
                                     focusedBorder:
                                     OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(16.h),
                                         borderSide:BorderSide(color: appTheme.buttonColor)
                                     ),
                                   ),
                                 ),
                               ),

                             ),
                             Padding(
                                 padding: EdgeInsets.only(left: 16.h),
                                 child: CustomIconButton(
                                     height: 56.adaptSize,
                                     width: 56.adaptSize,
                                     padding: EdgeInsets.all(16.h),
                                     decoration: IconButtonStyleHelper.fillPrimary,
                                     onTap: () {
                                       onTapBtnIconButton();
                                     },
                                     child: CustomImageView(
                                         imagePath: ImageConstant.imgGroup1171275017)))
                           ])),
                   SizedBox(height: 27.v),
                   Align(
                       alignment: Alignment.centerLeft,
                       child: Padding(
                           padding: EdgeInsets.only(left: 25.h),
                           child: GestureDetector(
                             onTap: (){
                               controller.searchList.clear();
                               controller.isFilter = false;
                               controller.update(["search"]);
                             },
                             child: Text("Refresh",//"lbl_recent".tr,
                                 style: theme.textTheme.titleMedium!.copyWith(
                                   color: appTheme.buttonColor,
                                     fontFamily: 'Montserrat-Medium'
                                 )),
                           ))),

                   SizedBox(height: 18.v),

                   Expanded(
                     child:
                     (controller.searchList.isEmpty && controller.isFilter == false)
                         ? controller.searchRecentList.isNotEmpty
                         ? ListView.builder(
                       padding: EdgeInsets.only(left: 20.h, right: 20.h),
                       primary: false,
                       shrinkWrap: true,
                       itemCount: controller.searchRecentList.length,
                       itemBuilder: (context, index) {

                         GroundDetailListModel model  = controller.searchRecentList[index];

                         return  FutureBuilder(
                             future: homeController.getLocationName(model.latitude.toDouble(), model.longitude.toDouble()),
                             builder: (context, cityName){
                               return  animationfunction(
                                   index,
                                   Padding(
                                       padding: EdgeInsets
                                           .symmetric(
                                           horizontal:
                                           8.h),
                                       child:
                                       GestureDetector(
                                         onTap: () {

                                           Get.toNamed(
                                               AppRoutes.detailScreen,  arguments: {
                                             "data" : model,
                                           });
                                         },
                                         child:
                                         Container(
                                             width: 298
                                                 .h,
                                             margin: EdgeInsets.only(bottom:  20.v),
                                             decoration: AppDecoration.fillGray.copyWith(
                                                 color: appTheme
                                                     .textfieldFillColor,
                                                 borderRadius: BorderRadiusStyle
                                                     .roundedBorder16),
                                             child: Column(
                                                 mainAxisSize:
                                                 MainAxisSize.min,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   buildSeventeen(image: model.image[0], distance: model.km),
                                                   SizedBox(height: 12.v),
                                                   Padding(
                                                     padding: EdgeInsets.symmetric(horizontal: 8.h),
                                                     child: SizedBox(
                                                       width: 375.h,
                                                       child: Text(model.title,
                                                           overflow: TextOverflow.ellipsis,
                                                           style: theme.textTheme.titleMedium!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium')
                                                       ),
                                                     ),
                                                   ),
                                                   SizedBox(height: 5.v),
                                                   Padding(
                                                     padding: EdgeInsets.symmetric(horizontal: 8.h),
                                                     child: Row(
                                                       children: [
                                                         CustomImageView(
                                                           color: appTheme.black900,
                                                           imagePath: ImageConstant.imgIcLocation,
                                                           height: 20.adaptSize,
                                                           width: 20.adaptSize,
                                                         ),
                                                         Padding(
                                                           padding: EdgeInsets.only(left: 8.h),
                                                           child: Text(cityName.data.toString(),
                                                               //controller.locationList[index],
                                                               style: theme.textTheme.bodyMedium!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium')),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                   SizedBox(height: 16.v)
                                                 ])),
                                       )),
                               );
                             }
                         );
                       },)
                         : Center(
                       child: Text("no_data_found".tr,
                           style: theme
                               .textTheme.displayMedium!
                               .copyWith(
                               color: appTheme
                                   .buttonColor,
                               fontSize: 14)),
                     )
                         : controller.searchList.isNotEmpty
                         ? ListView.builder(
                       padding: EdgeInsets.only(left: 20.h, right: 20.h),
                       primary: false,
                       shrinkWrap: true,
                       itemCount: controller.searchList.length,
                       itemBuilder: (context, index) {

                         GroundDetailListModel model  = controller.searchList[index];

                         return  FutureBuilder(
                             future: homeController.getLocationName(model.latitude.toDouble(), model.longitude.toDouble()),
                             builder: (context, cityName){
                               return  animationfunction(
                                   index,
                                   Padding(
                                       padding: EdgeInsets
                                           .symmetric(
                                           horizontal:
                                           8.h),
                                       child:
                                       GestureDetector(
                                         onTap: () {

                                           Get.toNamed(
                                               AppRoutes.detailScreen,  arguments: {
                                             "data" : model,
                                           });
                                         },
                                         child:
                                         Container(
                                             width: 298.h,
                                             margin: EdgeInsets.only(bottom:  20.v),
                                             decoration: AppDecoration.fillGray.copyWith(
                                                 color: appTheme
                                                     .textfieldFillColor,
                                                 borderRadius: BorderRadiusStyle
                                                     .roundedBorder16),
                                             child: Column(
                                                 mainAxisSize:
                                                 MainAxisSize.min,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   buildSeventeen(image: model.image[0], distance: model.km),
                                                   SizedBox(height: 12.v),
                                                   Padding(
                                                     padding: EdgeInsets.symmetric(horizontal: 8.h),
                                                     child: Text(model.title, style: theme.textTheme.titleMedium!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium')),
                                                   ),
                                                   SizedBox(height: 5.v),
                                                   Padding(
                                                     padding: EdgeInsets.symmetric(horizontal: 8.h),
                                                     child: Row(
                                                       children: [
                                                         CustomImageView(
                                                           color: appTheme.black900,
                                                           imagePath: ImageConstant.imgIcLocation,
                                                           height: 20.adaptSize,
                                                           width: 20.adaptSize,
                                                         ),
                                                         Padding(
                                                           padding: EdgeInsets.only(left: 8.h),
                                                           child: Text(cityName.data.toString(),
                                                               //controller.locationList[index],
                                                               style: theme.textTheme.bodyMedium!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium')),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                   SizedBox(height: 16.v)
                                                 ])),
                                       ))
                               );
                             }
                         );
                       },)
                         :  Center(
                       child: Text("no_data_found".tr,
                           style: theme
                               .textTheme.displayMedium!
                               .copyWith(
                               color: appTheme
                                   .buttonColor,
                               fontSize: 14)),
                     ),
                   ),

                   // SizedBox(height: 40.v),
                   // GestureDetector(
                   //   onTap: (){
                   //     controller.searchModelList.clear();
                   //     controller.update();
                   //   },
                   //   child: Text("lbl_clear_all".tr,
                   //       style: CustomTextStyles.titleMediumPrimaryBold),
                   // ),
                   SizedBox(height: 15.v)
                 ]),
               )),
           Obx(() => searchControllers.loader.value ? Center(child: CircularProgressIndicator()) : SizedBox())
         ],
       )
      ));
 }

 Widget buildSeventeen({
   required String image,
   required String distance,
 }) {
   return SizedBox(
       height: 163.v,
       width: double.infinity,
       child: Stack(alignment: Alignment.topRight, children: [
         Hero(
           tag: image,
           child: CustomImageView(
               imagePath: image,
               height: 163.v,
               width: double.infinity,
               radius: BorderRadius.circular(16.h),
               alignment: Alignment.center),
         ),
         Align(
             alignment: Alignment.topRight,
             child: Container(
                 margin: EdgeInsets.only(top: 12.v, right: 12.h),
                 padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
                 decoration: AppDecoration.white
                     .copyWith(borderRadius: BorderRadiusStyle.circleBorder10),
                 child: Text(distance,
                     style: theme.textTheme.bodySmall!.copyWith(
                         color: theme.colorScheme.onErrorContainer, fontFamily: 'Montserrat-Medium'))))
       ]));
 }


 /// Navigates to the homeContainerScreen when the action is triggered.
 onTapSearch() {
  Get.toNamed(
   AppRoutes.homeContainerScreen,
  );
 }

 /// Navigates to the filterScreen when the action is triggered.
 onTapBtnIconButton() {
  Get.toNamed(
   AppRoutes.filterScreen,
  );
 }
}





