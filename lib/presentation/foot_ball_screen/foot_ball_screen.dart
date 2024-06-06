// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/service/firebase_service.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/presentation/detail_screen/controller/detail_controller.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/presentation/detail_screen/models/ground_list_model.dart';
import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:sportsslot/presentation/popular_ground_screen/controller/popular_ground_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'controller/foot_ball_controller.dart';
import 'models/foot_ball_model.dart';


class FootBallScreen extends StatefulWidget {
  const FootBallScreen({super.key});

  @override
  State<FootBallScreen> createState() => _FootBallScreenState();
}

class _FootBallScreenState extends State<FootBallScreen> {

 FootBallController controller = Get.put(FootBallController());
 PopularGroundController popularGroundController = Get.put(PopularGroundController());
 HomeController homeController = Get.put(HomeController(HomeModel().obs));
 DetailController detailController = Get.put(DetailController());

 String categoryId = "";
 String categoryName = "";

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
     categoryId = Get.arguments["categoryId"];
    categoryName = Get.arguments["title"];
  }

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
          child: Column(
            children: [
              getCommonAppBar(
                  categoryName
                  // "lbl_foot_ball".tr
              ),
              SizedBox(height: 16.v),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseService.groundListCollection
                    .snapshots(),
                    builder: (context, snapshot){
                      controller.footBallList = [];

                      for(int i = 0 ; i<(snapshot.data?.docs.length??0); i++){
                        if(snapshot.data?.docs[i]["categoryIdList"].contains(categoryId)){
                          controller.footBallList.add(snapshot.data?.docs[i]);
                        }
                      }


                 if(snapshot.hasData){
                   return
                     controller.footBallList.isNotEmpty
                     ? ListView.builder(
                     primary: false,
                     shrinkWrap: true,
                     itemCount: snapshot.data?.docs.length,
                     itemBuilder: (context, index) {



                       var data = snapshot
                           .data?.docs[index];

                       double distance = Geolocator
                           .distanceBetween(
                         homeController
                             .position!.latitude,
                         homeController
                             .position!.longitude,
                         data?["mainGround"]
                         ["latitude"].toDouble(),
                         data?["mainGround"]
                         ["longitude"].toDouble(),
                       );

                       double distanceInKm = distance / 1000;

                       /// static
                       detailController.facilityList = DetailModel.getFacilityList();

                       detailController.groundList = []; //DetailModel.getGroundList();

                       for(int i = 0; i<data?["subGrounds"].length; i++){
                         detailController.groundList.add(
                             GroundListModel(
                             data?["subGrounds"][i]["id"],
                             data?["subGrounds"][i]["image"],
                             data?["subGrounds"][i]["name"],
                             "${data?["subGrounds"][i]["duration"]} Hour",
                             data?["subGrounds"][i]["price"],
                             data?["subGrounds"][i]["timeShifts"]
                         ));
                       }



                       bool isCategory = data?["categoryIdList"].contains(categoryId);





                       GroundDetailListModel model =
                       GroundDetailListModel(
                           stadiumId: data?.id ?? "",
                           image: data?["mainGround"]["image"],
                           km: "${distanceInKm.toStringAsFixed(2)} km",
                           latitude: data?["mainGround"]["latitude"].toDouble(),
                           longitude: data?["mainGround"]["longitude"].toDouble(),
                           price: "",//data?["price"].toStringAsFixed(2),
                           title: data?["mainGround"]["name"],
                           description: data?["mainGround"]["description"],
                           getFacilityList: detailController.facilityList,
                           getGroundList: detailController.groundList,
                           features: data?["features"],
                           review: data?["review"],
                         categoryId: data?["categoryIdList"],
                       );

                       return FutureBuilder(
                           future: homeController.getLocationName(data?["mainGround"]["latitude"].toDouble(), data?["mainGround"]["longitude"].toDouble()),
                           builder: (context, cityName){
                             return   isCategory?
                             animationfunction(index, Padding(
                               padding:  EdgeInsets.symmetric(vertical: 8.v),
                               child: GestureDetector(
                                 onTap: (){
                                   // popularGroundController.currentimage = model2.image!;
                                   // popularGroundController.groundsLocation = model2.location!;
                                   // popularGroundController.groundName = model.title;
                                   // popularGroundController.update();

                                   Get.toNamed(AppRoutes.detailScreen,  arguments: {
                                     "data" : model,
                                   });
                                 },
                                 child: Container(
                                     margin: EdgeInsets.symmetric(horizontal: 20.h),
                                     decoration: AppDecoration.fillGray
                                         .copyWith(
                                         color: appTheme.textfieldFillColor,
                                         borderRadius: BorderRadiusStyle.roundedBorder16),
                                     child: Column(
                                         mainAxisSize: MainAxisSize.min,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           buildSeventeen(
                                               image: model.image[0],
                                               distance: "${distanceInKm.toStringAsFixed(2)} km"),
                                           SizedBox(height: 12.v),
                                           Padding(
                                               padding: EdgeInsets.symmetric(horizontal: 8.h),
                                               child: Text(model.title!,
                                                   style: theme.textTheme.titleMedium!.copyWith(
                                                       color: appTheme.black900,fontFamily: 'Montserrat-Medium'
                                                   ))),
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
                                                   child: Text(
                                                       cityName.data.toString(),
                                                       style: theme.textTheme.bodyMedium!.copyWith(
                                                         color: appTheme.black900,
                                                       )
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ),
                                           SizedBox(height: 16.v)
                                         ])),
                               ),
                             )) : SizedBox();
                           }
                       );
                     },)
                       :
                   Center(
                     child: Text("no_data_found".tr,
                         style: theme
                             .textTheme.displayMedium!
                             .copyWith(
                             color: appTheme
                                 .buttonColor,
                             fontSize: 14)),
                   );
                 } else {
                   return Center(child: CircularProgressIndicator(),);
                 }
                })
              ),
            ],
          )
        )),
  );
 }

 onTapFootBall() {
  Get.toNamed(
   AppRoutes.categoriesScreen,
  );
 }


 Widget buildSeventeen({
   required String image,
   required String distance,
 }) {
   return SizedBox(
       height: 163.v,
       width: double.infinity,
       child: Stack(alignment: Alignment.topRight, children: [
         CustomImageView(
             imagePath: image,
             height: 163.v,
             width: double.infinity,
             radius: BorderRadius.circular(16.h),
             alignment: Alignment.center),
         Align(
             alignment: Alignment.topRight,
             child: Container(

                 margin: EdgeInsets.only(top: 12.v, right: 12.h),
                 padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
                 decoration: AppDecoration.white
                     .copyWith(borderRadius: BorderRadiusStyle.circleBorder10),
                 child: Text(distance,
                     style: theme.textTheme.bodySmall!.copyWith(
                         color: theme.colorScheme.onErrorContainer))))
       ]));
 }

}


