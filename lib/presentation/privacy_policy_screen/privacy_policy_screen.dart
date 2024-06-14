import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
//import 'package:html/parser.dart' as html;
import 'controller/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:html/parser.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  
  PrivacyPolicyController privacyPolicyController = Get.put(PrivacyPolicyController());

  @override
  void initState() {
    //privacyPolicy();
    super.initState();
  }

  // privacyPolicy() async{
  //
  //   await FirebaseFirestore.instance.collection(FirebaseKey.admin).doc(FirebaseKey.privacy).get().then((value) {
  //     privacyPolicyController.data.value = html.parse(value["description"].toString()).body?.text ?? '';
  //   });
  //
  // }



  @override
  Widget build(BuildContext context) {

    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: appTheme.bgColor,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCommonAppBar("lbl_privacy_policy".tr),
              SizedBox(height: 16.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        //Text("policy_title".tr, style: CustomTextStyles.titleMediumBold16),
                        //SizedBox(height: 16.v),
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance.collection(FirebaseKey.admin).doc(FirebaseKey.privacy).snapshots(),

                            builder: (context, snapshot){

                              if(snapshot.hasData){

                                privacyPolicyController.data.value = snapshot.data?["description"].toString()??"";

                                return SizedBox(
                                  width: double.infinity,
                                  child: HtmlWidget(privacyPolicyController.data.value),
                                  // child: Text(
                                  //   privacyPolicyController.data.value,
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

                        // ListView.separated(
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   separatorBuilder: (context, index) => SizedBox(height: 10),
                        //   itemCount: privacyPolicyController.privacyPolicyModelObj.length,
                        //   itemBuilder: (context, index) => Container(
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "${index + 1}.  ${privacyPolicyController.privacyPolicyModelObj[index].title}:",
                        //           style: CustomTextStyles.titleLarge22,
                        //         ),
                        //         SizedBox(height: 8),
                        //         Column(
                        //           children: List.generate(
                        //             (privacyPolicyController.privacyPolicyModelObj[index].data ?? []).length,
                        //                 (index2) => Padding(
                        //               padding: const EdgeInsets.only(left: 6),
                        //               child: Row(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text("◉", style: TextStyle(fontSize: 14,height: 0.9)),
                        //                   SizedBox(width: 4),
                        //                   SizedBox(
                        //                     width: Get.width - 53,
                        //                     child: Text(
                        //                       (privacyPolicyController.privacyPolicyModelObj[index].data ?? [])[index2].toString(),
                        //                       style: theme.textTheme.bodyLarge!.copyWith(color: appTheme.black900, height: 1.50),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
