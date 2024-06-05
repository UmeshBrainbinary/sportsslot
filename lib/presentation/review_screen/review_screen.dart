import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/service/firebase_service.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/detail_screen/controller/detail_controller.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import '../review_screen/widgets/review_item_widget.dart';
import 'controller/review_controller.dart';


class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  ReviewController controller = Get.put(ReviewController());
  DetailController detailController = Get.put(DetailController());
  late GroundDetailListModel groundDetailListModel;

  @override
  void initState() {
    // TODO: implement initState
    controller.stadiumId = Get.arguments["id"];
    groundDetailListModel = Get.arguments["data"];

    disable();



    super.initState();
  }

  disable() async{

   await FirebaseService.groundListCollection.doc(controller.stadiumId).get().then((value) {
     if(value["review"].isNotEmpty){
       for(var data1 in value["review"]){
         if(PrefUtils.getString(PrefKey.userId) == data1["userId"]){
           controller.isDisable = true;
           controller.update(["review"]);
         }
       }
     }
   });

  }


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return GetBuilder<ReviewController>(
      id: "review",
      builder: (controller) => Scaffold(
          backgroundColor: appTheme.bgColor,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCommonAppBar("lbl_reviews".tr),
                      SizedBox(height: 16.v),
                      Expanded(
                        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(

                            stream: FirebaseService.groundListCollection.doc(controller.stadiumId).snapshots(),

                            builder: (context, snapshot){

                              var data = snapshot.data;


                             if(snapshot.hasData){


                               return data?["review"].isNotEmpty
                                 ? ListView.separated(
                                   padding: EdgeInsets.only(left: 20.h,right: 20.h,bottom: 100.h),
                                   physics: BouncingScrollPhysics(),
                                   shrinkWrap: true,
                                   primary: false,
                                   separatorBuilder: (context, index) {
                                     return Opacity(
                                         opacity: 0.1,
                                         child: Padding(
                                             padding: EdgeInsets.symmetric(vertical: 15.0.v),
                                             child: SizedBox(
                                                 width: double.infinity,
                                                 child: Divider(
                                                     height: 1.v,
                                                     thickness: 1.v,
                                                     color: appTheme.gray60001))));
                                   },
                                   itemCount: data?["review"].length,
                                   itemBuilder: (context, index) {

                                     detailController.averageReview = 0.0;


                                     detailController.reviewListCount = data?["review"].length;

                                     for(int i = 0; i < data?["review"].length; i++) {
                                       detailController.averageReview += double.parse(data?["review"][i]["star"]);
                                     }

                                     detailController.averageReview = detailController.averageReview / detailController.reviewListCount;

                                     return ReviewItemWidget(
                                       data: data?["review"][index],
                                     );
                                   })
                                     : Center(
                              child: Text("no_data_found".tr,
                              style: theme
                                  .textTheme.displayMedium!
                                  .copyWith(
                              color: appTheme
                                  .buttonColor,
                              fontSize: 14)),
                              );
                             } else {
                               return SizedBox();
                             }
                            }
                        )
                      ),

                    ]),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 32.v,top: 16.v,left: 20.h,right: 20.h),
                    child:
                    controller.isDisable
                        ? Container(
                      height:  56.v,
                      width: double.infinity ,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: appTheme.buttonColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "lbl_write_a_reviews".tr,
                        style:
                        CustomTextStyles.titleMediumPrimaryContainer,
                      ),
                    )
                        : Container(

                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomElevatedButton(
                              width: double.infinity ,
                              text: "lbl_write_a_reviews".tr,
                              onPressed: () async {

                                await Get.toNamed(
                                  AppRoutes.writeAReviewScreen,
                                );


                                controller.onInit();
                                controller.update(["review"]);

                              },
                              alignment: Alignment.bottomCenter),
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          )),
    );
  }



  /// Navigates to the detailScreen when the action is triggered.
  onTapReviews() {
    Get.toNamed(
      AppRoutes.detailScreen,
    );
  }

  /// Navigates to the writeAReviewScreen when the action is triggered.
  onTapWriteAReviews() async {
    bool done = await Get.toNamed(
      AppRoutes.writeAReviewScreen,
    );
    if(done) {

    }
  }
}





