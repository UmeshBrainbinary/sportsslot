import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/service/firebase_service.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/presentation/help_screen/models/help_item_modal.dart';

import '../../core/expantiontile/src/types/expansion_tile_border_item.dart';
import 'controller/help_controller.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  
  HelpController helpController = Get.put(HelpController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: appTheme.bgColor,
        body: SafeArea(
          child: Column(
            children: [
              getCommonAppBar("lbl_help".tr),
              SizedBox(height: 0.v),
              Expanded(
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance.collection(FirebaseKey.admin).doc('faqs').snapshots(),
                    builder: (context, snapshot){
                     if(snapshot.hasData){

                       helpController.helpModelObj = [];

                       for(var data in snapshot.data?["queAns"]){
                         helpController.helpModelObj.add( HelpItemModal(
                           question: data["question"],
                           answer: data["answer"],
                         ),);
                       }


                       return ListView.separated(
                         separatorBuilder: (context, index) => SizedBox(height: 16.v),
                         itemCount: helpController.helpModelObj.length,
                         itemBuilder: (context, index) => _buildFrame(
                           whatIsPlayground: helpController.helpModelObj[index].question.toString(),
                           answer: helpController.helpModelObj[index].answer.toString(),
                         ),

                       );
                     } else{
                       return Center(
                         child: CircularProgressIndicator()
                       );
                     }
                    }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrame({required String whatIsPlayground, required String answer}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: ExpansionTileBorderItem(
        // collapsedIconColor: appTheme.black900,
        iconColor: appTheme.black900,
        childrenPadding: EdgeInsets.only(left: 20.h, right: 20.h, top: 0, bottom: 16.v),
        borderRadius: BorderRadius.circular(16.h),
        decoration: AppDecoration.fillGray.copyWith(
          color: appTheme.textfieldFillColor,
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: whatIsPlayground,
                style: theme.textTheme.titleMedium!.copyWith(color: appTheme.black900),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        expendedBorderColor: Colors.blue,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: double.infinity,
              child: Text(
                answer,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyLarge!.copyWith(color: appTheme.black900),
              ),
            ),
          )
        ],
      ),
    );
  }
}
