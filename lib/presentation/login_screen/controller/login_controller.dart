import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// A controller class for the LoginScreen.
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';

import 'package:sportsslot/presentation/login_screen/models/login_model.dart';

///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<LoginModel> loginModelObj = LoginModel().obs;

  Rx<bool> isShowPassword = true.obs;

  RxBool loader = false.obs;

  String passwordError = '';

  String emailError = '';

  bool isUser = true;

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    passwordController.clear();
  }


Map<String, dynamic> loginUserData = {

};


  Future<void> loginWithEmailAndPassword() async {
    //FirebaseAuth.instance.signOut();
    try {
      loader.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (userCredential.user != null) {
        print('User logged in successfully!');

        CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(FirebaseKey.users);

        QuerySnapshot querySnapshot = await collectionRef.get();
        QuerySnapshot querySnapshot2 = await collectionRef.where("email", isEqualTo: emailController.text.trim()).get();

        if(querySnapshot2.docs.isNotEmpty) {
          loginUserData = querySnapshot2.docs.first.data() as Map<String, dynamic>;
          loginUserData["docId"] = querySnapshot2.docs.first.id;
        }



        if(loginUserData[FirebaseKey.role] == FirebaseKey.user){

          await PrefUtils.setValue(PrefKey.isLoggedIn, true);
          await PrefUtils.setValue(PrefKey.userEmail, emailController.text.trim());
          await PrefUtils.setValue(PrefKey.userId, loginUserData["docId"]);
          await PrefUtils.setValue(PrefKey.userRole, FirebaseKey.user);
          await PrefUtils.setValue(PrefKey.fullName, "${loginUserData["firstName"]} ${loginUserData["lastName"]}");
          await PrefUtils.setValue(PrefKey.mobileNo, loginUserData["mobileNo"]);
          await PrefUtils.setValue(PrefKey.dob, loginUserData["dob"]);



          Get.offAllNamed(
            AppRoutes.homeContainerScreen
          );

        } else{
          errorToast("Invalid credential");
        }

      } else {
        // errorToast("Invalid credential");
      }

      loader.value = false;
    } catch (e) {
      if(e.toString().contains("invalid-credential"))
      {
        errorToast("Invalid credential");
      }
      else{
        errorToast("Something went wrong");
      }
      print('Error during login: $e');
      loader.value = false;
    }
  }






}
