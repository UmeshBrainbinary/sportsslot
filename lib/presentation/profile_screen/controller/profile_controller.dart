
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/profile_screen/models/profile_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the ProfileScreen.
///
/// This class manages the state of the ProfileScreen, including the
/// current profileModelObj
class ProfileController extends GetxController {
  TextEditingController profileController = TextEditingController();

  TextEditingController profileController1 = TextEditingController();

  TextEditingController profileController2 = TextEditingController();

  TextEditingController profileController3 = TextEditingController();

  Rx<ProfileModel> profileModelObj = ProfileModel().obs;

  RxBool loader = false.obs;

  RxBool switchValue = true.obs;

  @override
  void onClose() {
    super.onClose();
    profileController.dispose();
    profileController1.dispose();
    profileController2.dispose();
    profileController3.dispose();
  }


  RxString fullName = "".obs;
  RxString email = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;




  Future<void> getProfileDetails() async{
    loader.value = true;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(FirebaseKey.users).doc(PrefUtils.getString(PrefKey.userId)).get();

    Map<String, dynamic> data =  snapshot.data() as Map<String, dynamic>;

    email.value = data['email'];
    fullName.value = "${data['firstName']} ${data['lastName']}";
    firstName.value = data['firstName'];
    lastName.value = data['lastName'];

    loader.value = false;

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileDetails();
  }



}
