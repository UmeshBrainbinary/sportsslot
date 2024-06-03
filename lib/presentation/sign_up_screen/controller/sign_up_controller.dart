import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A controller class for the SignUpScreen.
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/sign_up_screen/models/sign_up_model.dart';

import 'package:intl/intl.dart';

///
/// This class manages the state of the SignUpScreen, including the
/// current signUpModelObj
class SignUpController extends GetxController {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController mobileNumberController = TextEditingController();

  //Rx<SignUpModel> signUpModelObj = SignUpModel().obs;

  Rx<bool> isShowPassword = true.obs;

  RxBool loader = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String fcmToken = "";

  Future<void> onTapPickDatePlayer({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(0),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    update(["player"]);
  }



  Future<bool> signUpWithEmailAndPassword() async {
    try {
      loader.value = true;
      bool isSuccess = false;
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      if (userCredential.user != null && userCredential.user?.uid != null) {




        var userQuery = await FirebaseFirestore.instance
            .collection(FirebaseKey.users)
            .where('email', isEqualTo: emailController.text.trim())
            .get();


        try {
          await FirebaseMessaging.instance.getToken().then((value) {

            PrefUtils.setValue(PrefKey.fcmToken, value);
            if (kDebugMode) {
              print("FCM token sign up => $value");
            }
          });
        } catch (e) {
          print(e);
        }

        SignUpModel newUser = SignUpModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          dob: dateOfBirthController.text.trim(),
          mobileNo: mobileNumberController.text.trim(),
          role: FirebaseKey.user,
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          fcmToken: fcmToken,
        );

        if (userQuery.docs.isEmpty) {
          await FirebaseFirestore.instance
              .collection(FirebaseKey.users)
              .add(newUser.toMap());
           userQuery = await FirebaseFirestore.instance
              .collection(FirebaseKey.users)
              .where('email', isEqualTo: emailController.text.trim())
              .get();
        } else {

          /// UPDATE HERE

          userQuery.docs.forEach((doc) {
            doc.reference.update(newUser.toMap());
          });
        }

        await PrefUtils.setValue(PrefKey.isLoggedIn, true);

        await PrefUtils.setValue(PrefKey.userEmail, emailController.text.trim());
        await PrefUtils.setValue(PrefKey.userRole, FirebaseKey.user);

        await PrefUtils.setValue(PrefKey.userId, userQuery.docs.first.id);

        await PrefUtils.setValue(PrefKey.fullName, "${firstNameController.text.trim()} ${lastNameController.text.trim()}");
        await PrefUtils.setValue(PrefKey.mobileNo, mobileNumberController.text.trim());
        await PrefUtils.setValue(PrefKey.dob, dateOfBirthController.text.trim());


        // Get.toNamed(
        //   AppRoutes.homeContainerScreen,
        // );

        isSuccess = true;
      }
      //await PrefUtils.setValue(PrefKey.isLoggedIn, true);
      loader.value = false;
      return isSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorToast("The account already exists for that email.");
      }
      print(e);
      loader.value = false;
      return false;
    }
    catch (e) {


      print(e.toString());
      loader.value = false;
      return false;
    }
  }





  @override
  void onClose() {
    super.onClose();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();

  }



}
