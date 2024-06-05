import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/edit_profile_screen/models/edit_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/presentation/profile_screen/controller/profile_controller.dart';

/// A controller class for the EditProfileScreen.
///
/// This class manages the state of the EditProfileScreen, including the
/// current editProfileModelObj
class EditProfileController extends GetxController {


 ProfileController profileController = Get.put(ProfileController());

  TextEditingController masterInputController = TextEditingController();

  TextEditingController masterInputController1 = TextEditingController();

  TextEditingController emailController = TextEditingController();

  Rx<EditProfileModel> editProfileModelObj = EditProfileModel().obs;

  RxBool loader  = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    masterInputController.text =  profileController.firstName.value;
    masterInputController1.text =  profileController.lastName.value;
    emailController.text =  profileController.email.value;
  }

  @override
  void onClose() {
    super.onClose();
    masterInputController.dispose();
    masterInputController1.dispose();
    emailController.dispose();
  }

  updateProfile ({required String firstName, required String lastName, required String email}) async{

    loader.value = true;
    await FirebaseFirestore.instance.collection(FirebaseKey.users).doc(PrefUtils.getString(PrefKey.userId)).update({
      "firstName": firstName,
      "lastName": lastName
    });



    profileController.fullName.value = "${firstName} ${lastName}";
    profileController.firstName.value = firstName;
    profileController.lastName.value = lastName;

    loader.value = false;

    Get.back();


  }


}
