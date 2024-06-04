import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/model/faq_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';

class FaqController extends GetxController {
  RxBool loader = false.obs;

  RxList<TextEditingController> questionController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> answerController =
      <TextEditingController>[].obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {

    loader.value = true;
    await getDescription();
    loader.value = false;
    questionController.refresh();
    answerController.refresh();
  }

  Future<void> getDescription() async {
    try {
      DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc("faqs")
          .get();

      if (docSnapShot.data() != null) {
        Map<String, dynamic> data = docSnapShot.data() as Map<String, dynamic>;

        FAQs faqData = FAQs.fromMap(data);
        questionController.value =
            List.generate(faqData.queAns?.length ?? 1, (index) => TextEditingController(text: faqData.queAns != null ?faqData.queAns![index].question: ""));
        answerController.value =
            List.generate(faqData.queAns?.length ?? 1, (index) => TextEditingController(text: faqData.queAns != null ?faqData.queAns![index].answer: ""));
        questionController.refresh();
        answerController.refresh();
      }
    } catch (e) {
      log("Error fetching privacy details: $e");
    }
  }


  Future<void> updateFaqs() async {
    try {
      loader.value = true;

  FAQs faqs = FAQs(queAns: []);
      for (int i = 0; i < questionController.value.length; i++) {
        Map<String, dynamic> questionAns = {
          'question': questionController.value[i].text.trim(),
          'answer': answerController.value[i].text.trim(),
        };
        faqs.queAns?.add(QueAns.fromMap(questionAns));
      }
      await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc("faqs")
          .update(faqs.toMap());
      loader.value = false;
      showToast("FAQs updated successfully");
    } catch (e) {
      loader.value = false;
      log("Error updating privacy details: $e");
    }
  }

  bool validateQuestionAns() {
    bool isValidate = true;
    for (int i = 0; i < questionController.value.length; i++) {
      if (questionController.value[i].text.trim().isEmpty ||
          answerController.value[i].text.trim().isEmpty) {
        isValidate = false;
      }
    }
    return isValidate;
  }

  Future<void> showDeleteConfirmationDialog(
      {required BuildContext context, required int index}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button for dismissal
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this FAQ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
              questionController.value.removeAt(index);
              answerController.value.removeAt(index);
              questionController.refresh();
              answerController.refresh();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
