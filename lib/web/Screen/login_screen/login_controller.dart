import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_screen.dart';
import 'package:sportsslot/web/Screen/logo_icon/logo_icon_screen.dart';
import 'package:sportsslot/web/model/user_model.dart';
import 'package:sportsslot/web/service/pref_service.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';
import 'package:sportsslot/web/utils/pref_keys.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool loader = false.obs;
  String emailError = '';

  bool passView = true;

  emailValidation() {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (emailController.text.isEmpty) {
      emailError = 'Email address can not be empty';
    } else if (!emailRegex.hasMatch(emailController.text)) {
      emailError = 'Invalid email address format';
    } else {
      emailError = "";
    }
  }

  String passwordError = '';

  passwordValidation() {
    if (passwordController.text.isEmpty) {
      passwordError = "Password can not be empty";
    } else if (passwordController.text.length < 8) {
      passwordError = "Password must be 8 character";
    } else {
      passwordError = "";
    }
    update(['id']);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      return userCredential.user!.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> loginWithEmailAndPassword() async {
    FirebaseAuth.instance.signOut();
    try {
      loader.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      if (userCredential.user != null) {
        print('User logged in successfully!');

        CollectionReference collectionRef =
            FirebaseFirestore.instance.collection(Keys.users);
        QuerySnapshot querySnapshot = await collectionRef.get();
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          if (emailController.text.trim().toLowerCase() == documentSnapshot.get(Keys.email) &&  documentSnapshot.get(Keys.role) == Keys.admin) {
            await PrefService.setValue(PrefKeys.isLoggedIn, true);
            await PrefService.setValue(PrefKeys.userEmail, documentSnapshot.get(Keys.email));
            await PrefService.setValue(PrefKeys.userRole, documentSnapshot.get(Keys.email));

            print("login users role is ------------------- ${documentSnapshot.get(Keys.email)}");
          }
        }

        Get.offAll(() => DashboardScreen(child: LogoIconScreen(), index: 0));
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

  Future<bool> signUpWithEmailAndPassword({String? role}) async {
    try {
      loader.value = true;
      bool isSuccess = false;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      if (userCredential.user != null && userCredential.user?.uid != null) {
        var userQuery = await FirebaseFirestore.instance
            .collection(Keys.users)
            .where('email', isEqualTo: emailController.text.trim())
            .get();

        UserModel newUser = UserModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          role: role ?? Keys.admin,
        );

        if (userQuery.docs.isEmpty) {
          await FirebaseFirestore.instance
              .collection(Keys.users)
              .add(newUser.toMap());
        } else {
          /// UPDATE HERE
          // userQuery.docs.forEach((doc) {
          //   doc.reference.update(newUser.toMap());
          // });
        }

        await PrefService.setValue(PrefKeys.isLoggedIn, true);
        await PrefService.setValue(PrefKeys.userRole, role ?? Keys.admin);
        isSuccess = true;
      }
      loader.value = false;
      return isSuccess;
    } catch (e) {
      print(e.toString());
      loader.value = false;
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
