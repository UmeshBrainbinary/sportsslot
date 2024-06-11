import 'package:sportsslot/presentation/my_profile_screen/controller/my_profile_controller.dart';
import 'package:sportsslot/presentation/rate_us_experirnce_screen/rate_us_experirnce_screen.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_icon_button.dart';
import 'package:in_app_review/in_app_review.dart';
import '../log_out_dialogue/log_out_dialogue.dart';
import 'controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileController controller = Get.put(ProfileController());

  final InAppReview _inAppReview = InAppReview.instance;


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Stack(
      children: [
        Column(
          children: [
            buildComponentOne(),
            SizedBox(height: 18.v),
            Obx(() =>  Padding(
              padding: EdgeInsets.only(
                left: 15.h,
                top: 16.v,
                bottom: 13.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgAvtar1,
                    height: 100.adaptSize,
                    width: 100.adaptSize,
                    fit: BoxFit.contain,
                    radius:
                    BorderRadius.circular(50.h),
                  ),
                  SizedBox(height: 12.v),
                  Text(
                    controller.fullName.value??"",
                    style: theme.textTheme.titleLarge!.copyWith(
                        color: appTheme.black900,
                        fontFamily: 'Montserrat-Medium'
                    ),
                  ),


                ],
              ),
            ),),


            SizedBox(height: 32.v),
            Expanded(
              child: ListView(
                children: [

                  buildIcAboutUs(() {
                    //Get.toNamed(AppRoutes.myProfileScreen);

                    Get.toNamed(AppRoutes.editProfileScreen);
                  },
                    "lbl_account".tr, ImageConstant.imgLightProfile,
                  ),



                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(height: 0.5, color: Colors.grey.withOpacity(0.25)
                      )
                  ),




                  buildIcAboutUs(() {
                    Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
                    "Privacy policy".tr, ImageConstant.imgIcPrivacyPolicy,
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(height: 0.5, color: Colors.grey.withOpacity(0.25))),

                  buildIcAboutUs(() {
                    Get.toNamed(AppRoutes.helpScreen);
                  },
                    "lbl_faq".tr, ImageConstant.imgIcHelp,
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(height: 0.5, color: Colors.grey.withOpacity(0.25))),

                  buildIcAboutUs(() {
                    Get.toNamed(AppRoutes.aboutUsScreen);
                  },
                    "lbl_about_us".tr, ImageConstant.imgIcAboutUs,
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(height: 0.5, color: Colors.grey.withOpacity(0.25))),

                  buildIcAboutUs(()   {

                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          contentPadding: EdgeInsets.zero,
                          content: RateUsExperirnceScreen(),
                        );
                      },
                    );

                    /// in app review
                    // if (await _inAppReview.isAvailable()) {
                    // Future.delayed(const Duration(seconds: 1), () {
                    // _inAppReview.requestReview();
                    // });
                    // } else{
                    //   print("not available");
                    // }

                  },
                    "lbl_rate_us".tr, ImageConstant.imgStar120x20,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(height: 0.5, color: Colors.grey.withOpacity(0.25))),

                  _buildProfile1((){

                    ThemeHelper().changeTheme();
                    setSafeAreaColor();
                  },
                    ImageConstant.imgThemeIcon,
                    "Theme",
                    PrefUtils().getThemeData() == "primary"?ImageConstant.imgSwitchOff:ImageConstant.imgSwitchOn),

                  SizedBox(height: 32.v),

                  Center(
                    child:
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CustomElevatedButton(
                          text: "Logout",
                          onPressed: controller.loader.value ? (){} : () async{

                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    insetPadding: EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    contentPadding: EdgeInsets.zero,
                                    content: LogOutDialogue());
                              },
                            );

                          }),
                    ),
                  ),
                  SizedBox(height: 16.v),
                ],
              ),
            )
          ],
        ),
        Obx(() => controller.loader.value? Center(child: CircularProgressIndicator(),) : SizedBox())
      ],
    );
  }

  /// Section Widget
  Widget _buildProfile1(function,prefixicon,title,suffixIcon) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.h),
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: AppDecoration.fillGray.copyWith(
          color: Colors.transparent,//appTheme.textfieldFillColor,
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Row(
          children: [
            CustomImageView(
              color: appTheme.black900,
              imagePath: prefixicon,
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.h,
                top: 15.v,
                bottom: 12.v,
              ),
              child: Text(
                title,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: appTheme.black900,
                    fontFamily: 'Montserrat-Medium'
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: function,
              child: CustomImageView(
                imagePath: suffixIcon,
                //color: PrefUtils().getThemeData() == "primary" ? null : appTheme.themeColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget buildComponentOne() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 17.v),
      decoration: AppDecoration.white.copyWith(color: appTheme.bgColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.v),
          Text(
            "lbl_profile".tr,
            style: theme.textTheme.headlineMedium!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium'),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget buildIcAboutUs(onTap, title, icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.h),
          decoration: AppDecoration.fillGray.copyWith(
            color: Colors.transparent,  //appTheme.textfieldFillColor,
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                color: appTheme.black900,
                imagePath: icon,
                height: 24.adaptSize,
                width: 24.adaptSize,
                alignment: Alignment.center,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.h, top: 14.v, bottom: 13.v),
                child: Text(
                  title,
                  style: theme.textTheme.bodyLarge!.copyWith(color: appTheme.black900, fontFamily: 'Montserrat-Medium'),
                ),
              ),
              Spacer(),
              CustomImageView(
                color: appTheme.black900,
                imagePath: ImageConstant.imgIcNextOnerrorcontainer,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.only(top: 14.v, right: 8.h, bottom: 13.v),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
