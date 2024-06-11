// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/core/utils/validation_functions.dart';
import 'package:sportsslot/presentation/profile_screen/controller/profile_controller.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_icon_button.dart';
import 'package:sportsslot/widgets/custom_text_form_field.dart';
import 'controller/edit_profile_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
 EditProfileController controller = Get.put(EditProfileController());
 GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Form(
                  key: _formKey,
                  child: Column(children: [
                    getCommonAppBar("lbl_edit_profile".tr),
                    SizedBox(height: 24.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20.h),
                            child: Row(children: [
                              SizedBox(
                                  height: 80.adaptSize,
                                  width: 80.adaptSize,
                                  child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CustomImageView(
                                            imagePath:
                                            ImageConstant.imgAvtar1,
                                            height: 80.adaptSize,
                                            width: 80.adaptSize,
                                            radius: BorderRadius.circular(40.h),
                                            alignment: Alignment.center),
                                        CustomIconButton(
                                            height: 40.adaptSize,
                                            width: 40.adaptSize,
                                            padding: EdgeInsets.all(8.h),
                                            decoration: IconButtonStyleHelper
                                                .outlineBlack,
                                            alignment: Alignment.bottomRight,
                                            child: CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgGroup1171274939))
                                      ])),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 15.h, top: 12.v, bottom: 9.v),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text( profileController.fullName.value,
                                            style:
                                            theme.textTheme.titleLarge!.copyWith(
                                              color: appTheme.black900,
                                                fontFamily: 'Montserrat-Medium'
                                            )
                                        ),
                                        SizedBox(height: 14.v),
                                        Text(profileController.email.value,
                                            style: theme.textTheme.bodyLarge!.copyWith(
                                              color: appTheme.black900,
                                                fontFamily: 'Montserrat-Medium'
                                            )
                                        )
                                      ]))
                            ]))),
                    SizedBox(height: 32.v),
                    _buildMasterInput(),
                    SizedBox(height: 25.v),
                    _buildMasterInput1(),
                    SizedBox(height: 25.v),
                    _buildEmail(),
                    SizedBox(height: 5.v)
                  ])),
             Obx(() =>  controller.loader.value ? Center(child: CircularProgressIndicator(),) : SizedBox()),
            ],
          )
        ),
        bottomNavigationBar: buildButtons()),
  );
 }



 /// Section Widget
 Widget _buildMasterInput() {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: CustomTextFormField(
          controller: controller.masterInputController,
          prefix: Transform.scale(
            scale: 0.4,
            child: Image.asset(ImageConstant.user, color: appTheme.gray600, height: 20),
          ),
          hintText: "First name"));
 }

 /// Section Widget
 Widget _buildMasterInput1() {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: CustomTextFormField(
          controller: controller.masterInputController1,
          prefix: Transform.scale(
            scale: 0.4,
            child: Image.asset(ImageConstant.user, color: appTheme.gray600, height: 20),
          ),
          hintText: "Last name"));
 }

 /// Section Widget
 Widget _buildEmail() {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: CustomTextFormField(
          controller: controller.emailController,
          hintText: "Email address",
          enable: false,
          textInputAction: TextInputAction.done,
          prefix: Transform.scale(
            scale: 0.4,
            child: Image.asset(ImageConstant.email, color: appTheme.gray600, height: 20),
          ),
          textInputType: TextInputType.emailAddress,
          fillColor: PrefUtils().getThemeData() == "primary" ? appTheme.gray300 : Color(0XFF6e6e6e),
          validator: (value) {
           if (value == null || (!isValidEmail(value, isRequired: true))) {
            return "err_msg_please_enter_valid_email".tr;
           }
           return null;
          }));
 }

 /// Section Widget
 Widget buildSave() {
  return Padding(
    padding: EdgeInsets.only(top: 16.v,bottom: 32.v,left: 20.h,right: 20.h),
    child: CustomElevatedButton(
        text: "lbl_save".tr,
        onPressed: () {
          if(controller.masterInputController.text.isNotEmpty && controller.masterInputController1.text.isNotEmpty && controller.emailController.text.isNotEmpty){
            controller.updateProfile(
              firstName: controller.masterInputController.text.trim(),
              lastName: controller.masterInputController1.text.trim(),
              email: controller.emailController.text.trim()
            );
          } else{
            errorToast("Required fill up all fields");
          }

        }),
  );
 }

 /// Section Widget
 Widget buildButtons() {
  return Container(
   width: double.infinity,
      color: appTheme.bgColor,
      child: buildSave());
 }

 /// Navigates to the myProfileScreen when the action is triggered.
 onTapEditProfile() {
  Get.toNamed(
   AppRoutes.myProfileScreen,
  );
 }

 /// Navigates to the myProfileScreen when the action is triggered.
 onTapSave() {
  Get.toNamed(
   AppRoutes.myProfileScreen,
  );
 }
}





