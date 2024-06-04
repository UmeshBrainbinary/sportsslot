import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';

class AboutController extends GetxController {
  TextEditingController descController = TextEditingController();

  RxBool loader = false.obs;

  RxString htmlResponseForEdit = "".obs;
  RxString htmlResponseForSend = "".obs;

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.strike,
    ToolBarStyle.size,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.align,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.undo,
    ToolBarStyle.redo
  ];


  // @override
  // void onInit() {
  //   init();
  //   super.onInit();
  // }

  Future<void> init() async {
    loader.value = true;
    await getDescription();
    loader.value = false;
  }

  Future<void> getDescription() async {
    try {
      DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc("about")
          .get();

      if (docSnapShot.data() != null) {
        Map<String, dynamic> data = docSnapShot.data() as Map<String, dynamic>;

        htmlResponseForEdit.value = data["description"];
      }
    } catch (e) {
      log("Error fetching about details: $e");
    }
  }


  Future<void> updateDescription() async {
    try {
      loader.value = true;
      await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc("about")
          .update({
        "description":htmlResponseForSend.value,
      });
      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("Error updating about details: $e");
    }
  }





}
