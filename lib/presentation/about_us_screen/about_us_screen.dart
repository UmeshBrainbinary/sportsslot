
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' as html;
import 'controller/about_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';



class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  AboutUsController aboutUsController = Get.put(AboutUsController());

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: () async{
        Get.back();
        return true;
      },
      child: Scaffold(
      backgroundColor: appTheme.bgColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCommonAppBar("lbl_about_us".tr),
             Expanded(
               child: Container(
                 child: ListView(
                   padding: EdgeInsets.symmetric(horizontal: 20.h),
                   children: [

                     ///

                     StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                         stream: FirebaseFirestore.instance.collection(FirebaseKey.admin).doc(FirebaseKey.about).snapshots(),

                         builder: (context, snapshot){

                           if(snapshot.hasData){

                             aboutUsController.data.value = snapshot.data?["description"].toString() ?? "";



                             return SizedBox(
                               width: double.infinity,
                               child:  HtmlWidget(aboutUsController.data.value),
                               // child: Text(
                               // aboutUsController.data.value
                               //
                               //   style: theme.textTheme.bodyLarge!.copyWith(
                               //     color: appTheme.black900,
                               //     height: 1.50,
                               //   ),
                               // ),
                             );
                           } else{
                             return SizedBox();
                           }


                         }
                     )



                     ///
                     // SizedBox(height: 18.v),
                     // Container(
                     //   width: double.infinity,
                     //   margin: EdgeInsets.only(right: 14.h),
                     //   child: Text(
                     //     "about_us_msg_1".tr,
                     //     maxLines: 4,
                     //     overflow: TextOverflow.ellipsis,
                     //     style: theme.textTheme.bodyLarge!.copyWith(
                     //       color: appTheme.black900,
                     //       height: 1.50,
                     //     ),
                     //   ),
                     // ),
                     // SizedBox(height: 16.v),
                     // SizedBox(
                     //   width: double.infinity,
                     //   child: Text(
                     //     "about_us_msg_2".tr,
                     //     maxLines: 3,
                     //     overflow: TextOverflow.ellipsis,
                     //     style: theme.textTheme.bodyLarge!.copyWith(
                     //       color: appTheme.black900,
                     //       height: 1.50,
                     //     ),
                     //   ),
                     // ),
                     // SizedBox(height: 16.v),
                     // SizedBox(
                     //   width: double.infinity,
                     //   child: Text(
                     //     "about_us_msg_3".tr,
                     //     maxLines: 3,
                     //     overflow: TextOverflow.ellipsis,
                     //     style: theme.textTheme.bodyLarge!.copyWith(
                     //       color: appTheme.black900,
                     //       height: 1.50,
                     //     ),
                     //   ),
                     // ),

                   ],
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}



