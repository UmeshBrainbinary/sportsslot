import 'package:sportsslot/presentation/my_profile_screen/controller/my_profile_controller.dart';
import 'package:sportsslot/presentation/rate_us_experirnce_screen/rate_us_experirnce_screen.dart';
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
            SizedBox(height: 24.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgAvtar1,
                      height: 80.adaptSize,
                      width: 80.adaptSize,
                    ),
                    Obx(() =>  Padding(
                      padding: EdgeInsets.only(
                        left: 15.h,
                        top: 16.v,
                        bottom: 13.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.fullName.value??"",
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: appTheme.black900,
                            ),
                          ),
                          SizedBox(height: 6.v),
                          Text(
                            controller.email.value??"",
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: appTheme.black900,
                            ),
                          ),
                        ],
                      ),
                    ),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.v),
            Expanded(
              child: ListView(
                children: [

                  buildIcAboutUs(() {
                    //Get.toNamed(AppRoutes.myProfileScreen);

                    Get.toNamed(AppRoutes.editProfileScreen);
                  },
                    "lbl_my_profile".tr, ImageConstant.imgLightProfile,
                  ),

                  SizedBox(height: 16.v),

                  /// settings
                  // buildIcAboutUs(() {
                  //   Get.toNamed(AppRoutes.settingsScreen);
                  // },
                  //   "lbl_settings".tr, ImageConstant.imgIcSettings,
                  // ),
                  //
                  // SizedBox(height: 16.v),

                  buildIcAboutUs(() {
                    Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
                    "Privacy policy".tr, ImageConstant.imgIcPrivacyPolicy,
                  ),

                  SizedBox(height: 16.v),

                  buildIcAboutUs(() {
                    Get.toNamed(AppRoutes.helpScreen);
                  },
                    "lbl_faq".tr, ImageConstant.imgIcHelp,
                  ),

                  SizedBox(height: 16.v),

                  buildIcAboutUs(() {
                    Get.toNamed(AppRoutes.aboutUsScreen);
                  },
                    "lbl_about_us".tr, ImageConstant.imgIcAboutUs,
                  ),

                  SizedBox(height: 16.v),

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
                  SizedBox(height: 16.v),

                  _buildProfile1((){

                    ThemeHelper().changeTheme();
                    setSafeAreaColor();
                  },
                    ImageConstant.imgThemeIcon,
                    "Theme mode",
                    PrefUtils().getThemeData() == "primary"?ImageConstant.imgSwitchOff:ImageConstant.imgSwitchOn),

                  SizedBox(height: 16.v),

                  Center(
                    child: GestureDetector(
                      onTap: () {
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
                      },
                      child: Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text("Logout", style: CustomTextStyles.titleMediumPrimary700)),
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
          color: appTheme.textfieldFillColor,
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Row(
          children: [
            CustomIconButton(
              height: 48.adaptSize,
              width: 48.adaptSize,
              padding: EdgeInsets.all(12.h),
              decoration: IconButtonStyleHelper.fillPrimaryContainerTL24,
              child: CustomImageView(
                color: appTheme.black900,
                imagePath: prefixicon,
              ),
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
            style: theme.textTheme.headlineMedium!.copyWith(color: appTheme.black900),
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
            color: appTheme.textfieldFillColor,
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 48.adaptSize,
                width: 48.adaptSize,
                padding: EdgeInsets.all(12.h),
                decoration: AppDecoration.white.copyWith(
                  color: PrefUtils().getThemeData() == "primary"
                      ? appTheme.whiteA700
                      : appTheme.lightgraynightMode,
                  borderRadius: BorderRadiusStyle.circleBorder24,
                ),
                child: CustomImageView(
                  color: appTheme.black900,
                  imagePath: icon,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.h, top: 14.v, bottom: 13.v),
                child: Text(
                  title,
                  style: theme.textTheme.bodyLarge!.copyWith(color: appTheme.black900),
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
