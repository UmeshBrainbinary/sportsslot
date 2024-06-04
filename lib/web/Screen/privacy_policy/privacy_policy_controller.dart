// // import 'package:html/dom.dart';
// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_playground_booking_app/core/app_export.dart';
// import 'package:flutter_playground_booking_app/web/utils/firebase_keys.dart';
// import 'package:quill_html_editor/quill_html_editor.dart';
// // import 'package:flutter_quill/flutter_quill.dart';
//
// class PrivacyPolicyController extends GetxController{
//   TextEditingController privacyController = TextEditingController();
//   RxBool loader = false.obs;
//
//
//   late QuillEditorController controller;
//
//   final toolbarColor = Colors.white;
//   final backgroundColor = Colors.white70;
//   final toolbarIconColor = Colors.black87;
//   final editorTextStyle = const TextStyle(
//       fontSize: 18,
//       color: Colors.black,
//       fontWeight: FontWeight.normal,
//       fontFamily: 'Roboto');
//   final hintTextStyle = const TextStyle(
//       fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);
//
//
//   final customToolBarList = [
//     ToolBarStyle.bold,
//     ToolBarStyle.italic,
//     ToolBarStyle.underline,
//     ToolBarStyle.color,
//     ToolBarStyle.background,
//     ToolBarStyle.size,
//     ToolBarStyle.strike,
//     ToolBarStyle.align,
//     ToolBarStyle.listBullet,
//     ToolBarStyle.listOrdered,
//     ToolBarStyle.undo,
//     ToolBarStyle.redo
//   ];
//
//   @override
//   void onInit() {
//     init();
//     super.onInit();
//   }
//
//   Future<void> init() async {
//     loader.value = true;
//     await getDescription();
//     loader.value = false;
//   }
//
//   Future<void> getDescription() async {
//     try {
//       DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
//           .collection(Keys.admin)
//           .doc("privacy")
//           .get();
//
//       if (docSnapShot.data() != null) {
//         Map<String, dynamic> data = docSnapShot.data() as Map<String, dynamic>;
//
//         privacyController.text = data["description"];
//       }
//     } catch (e) {
//       log("Error fetching privacy details: $e");
//     }
//   }
//
//
//   Future<void> updateDescription() async {
//     try {
//       loader.value = true;
//       await FirebaseFirestore.instance
//           .collection(Keys.admin)
//           .doc("privacy")
//           .update({
//         "description":privacyController.text.trim(),
//       });
//       loader.value = false;
//     } catch (e) {
//       loader.value = false;
//       log("Error updating privacy details: $e");
//     }
//   }
//
//
//
//
//
// }