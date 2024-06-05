// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/profile_screen/controller/profile_controller.dart';
import 'controller/my_profile_controller.dart';




class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileController controller = Get.put(MyProfileController());
  ProfileController profileController = Get.put(ProfileController());
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
          body: SafeArea(
            child: 
           Obx(() =>  Column(children: [
             getCommonAppBar("lbl_my_profile".tr,actionwidget: Padding(
               padding:  EdgeInsets.only(right: 20.h),
               child: InkWell(
                 onTap: onTapMyProfile,
                 child: CustomImageView(
                   color: appTheme.black900,
                   imagePath: ImageConstant.imgIcEdit,
                   height: 24.adaptSize,
                   width: 24.adaptSize,
                   margin: EdgeInsets.only(top: 2.v, bottom: 10.v),
                 ),
               ),
             )),
             SizedBox(height: 24.v),
             Align(
                 alignment: Alignment.centerLeft,
                 child: Padding(
                     padding: EdgeInsets.only(left: 20.h),
                     child: Row(children: [
                       CustomImageView(
                           imagePath: ImageConstant.imgAvtar1,
                           height: 80.adaptSize,
                           width: 80.adaptSize),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 15.h, top: 12.v, bottom: 9.v),
                           child: Column(
                               crossAxisAlignment:
                               CrossAxisAlignment.start,
                               children: [
                                 Text(profileController.fullName.value??"",
                                     style: theme.textTheme.titleLarge!.copyWith(
                                       color: appTheme.black900,
                                     )),
                                 SizedBox(height: 14.v),
                                 Text(profileController.email.value??"",
                                     style: theme.textTheme.bodyLarge!.copyWith(
                                       color: appTheme.black900,
                                     ))
                               ]))
                     ]))),
             SizedBox(height: 32.v),
             Padding(
                 padding: EdgeInsets.symmetric(horizontal: 20.h),
                 child: _buildLastName(
                     lastName: "lbl_first_name".tr, abram: profileController.firstName.value??"")),
             SizedBox(height: 16.v),
             Padding(
                 padding: EdgeInsets.symmetric(horizontal: 20.h),
                 child: _buildLastName(
                     lastName: "lbl_last_name".tr, abram: profileController.lastName.value??"")),
             SizedBox(height: 16.v),
             Padding(
                 padding: EdgeInsets.symmetric(horizontal: 20.h),
                 child: _buildLastName(
                     lastName: "lbl_email_address".tr,
                     abram: profileController.email.value??"")),
             SizedBox(height: 5.v)
           ]),)
          )),
    );
  }


  /// Common widget
  Widget _buildLastName({
    required String lastName,
    required String abram,
  }) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 17.v),
        decoration: AppDecoration.fillGray
            .copyWith(
            color: appTheme.textfieldFillColor,
            borderRadius: BorderRadiusStyle.roundedBorder16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lastName,
                  style: CustomTextStyles.bodyLargeGray60001
                      .copyWith(color: appTheme.gray60001)),
              SizedBox(height: 8.v),
              Text(abram,
                  style: CustomTextStyles.titleMedium16
                      .copyWith(color: appTheme.black900))
            ]));
  }

  /// Navigates to the profileScreen when the action is triggered.
  onTapMyProfile() {
    Get.toNamed(
      AppRoutes.editProfileScreen,
    );
  }

  /// Navigates to the editProfileScreen when the action is triggered.
  onTapImgIcEdit() {
    Get.toNamed(
      AppRoutes.editProfileScreen,
    );
  }
}




