import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/validation_functions.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_text_form_field.dart';
import 'controller/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
 SignUpController controller = Get.put(SignUpController());
 GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return Scaffold(
    backgroundColor: appTheme.bgColor,

      body: SafeArea(
        child: Stack(
          children: [
           Form(
               key: _formKey,
               child: Container(
                 width: double.maxFinite,
                 padding:
                 EdgeInsets.symmetric(horizontal: 20.h, vertical: 36.v),
                 child: Column(
                     children: [
                       Align(
                           alignment: Alignment.centerLeft,
                           child: Text("lbl_sign_up".tr,
                             style: theme.textTheme.headlineMedium!.copyWith(color:appTheme.black900),
                           )),
                       SizedBox(height: 10.v),
                       Align(
                           alignment: Alignment.centerLeft,
                           child: Container(
                               width: 363.h, margin: EdgeInsets.only(right: 24.h),
                               child: Text("msg_please_enter_your".tr,
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                   style: theme.textTheme.bodyLarge!.copyWith(color:appTheme.black900, height: 1.50)))),
                       SizedBox(height: 45.v),
                   Expanded(child:  SingleChildScrollView(
                     child: Column(
                       children: [
                         buildFirstName(),
                         SizedBox(height: 25.v),
                         buildLastName(),
                         SizedBox(height: 25.v),
                         buildDateOfBirth(),
                         SizedBox(height: 25.v),
                         buildMobileNumber(),
                         SizedBox(height: 25.v),
                         buildEmail(),
                         SizedBox(height: 25.v),
                         buildPassword(),
                         SizedBox(height: 49.v),
                         buildSignUp(),
                         SizedBox(height: 49.v),
                         // Spacer(),
                         SizedBox(height: 11.v),
                         Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("msg_already_have_an".tr, style: CustomTextStyles.bodyLargeGray60001),
                               GestureDetector(
                                   onTap: () {
                                     Get.back();
                                   },
                                   child: Padding(
                                       padding: EdgeInsets.only(left: 4.h),
                                       child: Text("lbl_log_in".tr, style: CustomTextStyles.titleMediumPrimary)))
                             ])
                       ],
                     ),
                   ),),
                     ]),
               )),
            Obx(() => controller.loader.value ? Center(child: CircularProgressIndicator()) : SizedBox())
          ],
        )
      ));
 }

 /// Section Widget
 Widget buildFirstName() {
  return CustomTextFormField(
      controller: controller.firstNameController,
      hintText: "lbl_first_name".tr,
      validator: (value) {
       if (!isText(value) || value!.isEmpty) {
        return "err_msg_please_enter_valid_text".tr;
       }
       return null;
      });
 }


 /// mobile number
 Widget buildMobileNumber() {
   return CustomTextFormField(
       controller: controller.mobileNumberController,
       textInputType: TextInputType.phone,
       hintText: "lbl_mobile_number".tr,
       validator: (value) {
         if (!isNumeric(value) || value!.isEmpty || value.length != 10) {
           return "err_msg_please_enter_valid_number".tr;
         }
         return null;
       });
 }

 /// date of birth
 Widget buildDateOfBirth() {
   return CustomTextFormField(
       controller: controller.dateOfBirthController,
       hintText: "lbl_date_of_birth".tr,
       enable: false,
       readOnly: true,
       onTap: () {
         controller.onTapPickDatePlayer(context: context);
       },
       validator: (value) {
         if (value!.isEmpty) {
           return "err_msg_please_enter_valid_dateofbirth".tr;
         }
         return null;
       });
 }

 /// Section Widget
 Widget buildLastName() {
  return CustomTextFormField(
      controller: controller.lastNameController,
      hintText: "lbl_last_name".tr,
      validator: (value) {
       if (!isText(value) || value!.isEmpty) {
         return "err_msg_please_enter_valid_text".tr;
       }
       return null;
      });
 }

 /// Section Widget
 Widget buildEmail() {
  return CustomTextFormField(
      controller: controller.emailController,
      hintText: "lbl_email_address".tr,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
       if (value == null || (!isValidEmail(value, isRequired: true))) {
        return "err_msg_please_enter_valid_email".tr;
       }
       return null;
      });
 }

 /// Section Widget
 Widget buildPassword() {
  return Obx(() => CustomTextFormField(
      controller: controller.passwordController,
      hintText: "lbl_password".tr,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      suffix: InkWell(
          onTap: () {
           controller.isShowPassword.value =
           !controller.isShowPassword.value;
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(30.h, 18.v, 18.h, 18.v),
              child: CustomImageView(
                  color:appTheme.black900,
                  imagePath: !controller.isShowPassword.value?ImageConstant.imgIcEye:ImageConstant.imgIcEyeClose,
                  height: 20.adaptSize,
                  width: 20.adaptSize))),
      suffixConstraints: BoxConstraints(maxHeight: 56.v),
      validator: (value) {
       if (value == null || (!isValidPassword(value, isRequired: true))) {
        return "err_msg_please_enter_valid_password".tr;
       }
       return null;
      },
      obscureText: controller.isShowPassword.value,
      contentPadding: EdgeInsets.only(left: 16.h, top: 18.v, bottom: 18.v)));
 }

 /// Section Widget
 Widget buildSignUp() {
  return

 Obx(() =>  CustomElevatedButton(
   text: "lbl_sign_up".tr,
   onPressed: controller.loader.value ? (){} : () async{
     if(_formKey.currentState!.validate()){
       await controller.signUpWithEmailAndPassword();
     }
   },
 ));

 }

 /// Navigates to the homeContainerScreen when the action is triggered.
 onTapSignUp() {
   Get.back();
 }

 /// Navigates to the loginScreen when the action is triggered.
 onTapTxtLogIn() {
  Get.toNamed(
   AppRoutes.loginScreen,
  );
 }
}




