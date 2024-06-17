// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/validation_functions.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    setSafeAreaColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        closeApp();
        return false;
      },
      child: Scaffold(
          backgroundColor: appTheme.bgColor,
         // resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Form(
                    key: _formKey,
                    child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 36.v),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                              children: [
                            SizedBox(height: 20.v),

                            SvgPicture(SvgAssetLoader(ImageConstant.applogo), height: Get.height*0.12),

                            SizedBox(height: 60.v),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("lbl_log_in".tr,
                                    style: theme.textTheme.headlineMedium!.copyWith(
                                        color:appTheme.black900,fontFamily: 'Montserrat-Medium'
                                    ))),
                            SizedBox(height: 10.v),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    width: 363.h,
                                    margin: EdgeInsets.only(right: 24.h),
                                    child: Text("msg_please_enter_your".tr,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                            color:appTheme.black900,
                                            height: 1.50, fontFamily: 'Montserrat-Medium')))),
                            SizedBox(height: 45.v),
                            CustomTextFormField(
                                controller: controller.emailController,
                                hintText: "lbl_email_address".tr,
                                textInputType: TextInputType.emailAddress,
                                prefix: Transform.scale(
                                  scale: 0.4,
                                  child: Image.asset(ImageConstant.email, color: appTheme.gray600, height: 20,),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      (!isValidEmail(value, isRequired: true))) {
                                    return "Please enter valid email address.";
                                  }
                                  return null;
                                }),
                            SizedBox(height: 25.v),
                            Obx(() => CustomTextFormField(
                                controller: controller.passwordController,
                                hintText: "lbl_password".tr,
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.visiblePassword,
                                prefix: Transform.scale(
                                  scale: 0.4,
                                  child: Image.asset(ImageConstant.padlock, color: appTheme.gray600, height: 20),
                                ),
                                suffix: InkWell(
                                    onTap: () {
                                      controller.isShowPassword.value =
                                      !controller.isShowPassword.value;
                                    },
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            30.h, 18.v, 18.h, 18.v),
                                        child: CustomImageView(
                                            color: appTheme.black900,
                                            imagePath: !controller.isShowPassword.value?ImageConstant.imgIcEye:ImageConstant.imgIcEyeClose,
                                            height: 20.adaptSize,
                                            width: 20.adaptSize))),
                                suffixConstraints: BoxConstraints(maxHeight: 56.v),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter valid password.";
                                  }
                                  return null;
                                },
                                obscureText: controller.isShowPassword.value,
                                contentPadding: EdgeInsets.only(
                                    left: 16.h, top: 18.v, bottom: 18.v))),
                            SizedBox(height: 20.v),
                            Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      onTapTxtForgotPassword();
                                    },
                                    child: Text("msg_forgot_password".tr,
                                        style: theme.textTheme.bodyLarge!.copyWith(
                                            color:appTheme.black900,
                                            fontFamily: 'Montserrat-Medium'

                                        )))),
                            SizedBox(height: 48.v),

                          Obx(() =>
                              CustomElevatedButton(
                              text: "lbl_log_in".tr,
                              onPressed: controller.loader.value ? (){} : () async{

                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState!.validate()) {
                                  PrefUtils.setIsSignIn(false);
                                  await controller.loginWithEmailAndPassword();
                                }

                              }),
                          ),
                            //Spacer(),
                                SizedBox(height: 49.v),
                            SizedBox(height: 11.v),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 1.v),
                                      child: Text("msg_don_t_have_an_account".tr, style: CustomTextStyles.bodyLargeGray60001)),
                                  GestureDetector(
                                      onTap: () {
                                        onTapTxtSignUp();
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 4.h),
                                          child: Text("lbl_sign_up".tr, style: CustomTextStyles.titleMediumPrimary)))
                                ])
                          ]),
                        ))),
                Obx(() => controller.loader.value ? Center(child: CircularProgressIndicator()) : SizedBox())
              ],
            )
          )),
    );
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotPassword() {
    // Get.toNamed(
    //   AppRoutes.forgotPasswordScreen,
    // );
  }

  /// Navigates to the homeContainerScreen when the action is triggered.


  onTapTxtSignUp() {
    Get.toNamed(
      AppRoutes.signUpScreen,
    );
  }
}
