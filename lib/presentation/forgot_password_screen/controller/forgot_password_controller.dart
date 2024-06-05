import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/forgot_password_screen/models/forgot_password_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the ForgotPasswordScreen.
///
/// This class manages the state of the ForgotPasswordScreen, including the
/// current forgotPasswordModelObj
class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  Rx<ForgotPasswordModel> forgotPasswordModelObj = ForgotPasswordModel().obs;
  RxBool loader = false.obs;

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }




  Future<void> resetPassword({email, context}) async {
    loader.value = true;





    try {


      CollectionReference collectionRef =
      FirebaseFirestore.instance.collection(FirebaseKey.users);


      QuerySnapshot querySnapshot2 = await collectionRef.where("email", isEqualTo: email.trim()).get();

      if(querySnapshot2.docs.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email,
        );

        Get.back();

        showToast("Reset password link has been sent to your registered email, if not found please check your junk folder.");




      } else {
        errorToast("User not found");
      }




      loader.value = false;



    } catch (e) {
      print('Failed to send reset password email: $e');
      errorToast("Failed to send reset password email: $e");
      loader.value = false;
    }
  }
}
