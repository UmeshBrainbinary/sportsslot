import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController{
  RxBool loader = false.obs;
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

RxString titleError = "".obs;
RxString descError = "".obs;

  Future<List<String>> getFcmTokens() async {
      List<String> fcmTokens = [];
    try {
      CollectionReference usersRef = FirebaseFirestore.instance.collection(Keys.users);
      QuerySnapshot querySnapshot = await usersRef.where('fcmToken', isNotEqualTo: null)
          .where('fcmToken', isNotEqualTo: '')
          .get();
      querySnapshot.docs.forEach((doc) {
        Map<String,dynamic> userData =doc.data() as Map<String,dynamic>;
        fcmTokens.add(userData["fcmToken"]);
      });
    } catch (e) {
      log("Error fetching about details: $e");
    }
    return  fcmTokens;
  }

void validate(){
  if(titleController.text.isEmpty)
  {
    titleError.value = "Please enter title";
  }
  else{
    titleError.value = "";
  }
  if(descriptionController.text.isEmpty)
  {
    descError.value = "Please enter description";
  }
  else {
    descError.value = "";
  }
}

  Future<void> sendNotification(
      {required List<String> fcmTokens, required String title, required String body}) async {

    final String serverKey = 'AAAA5hZ0uDs:APA91bHBrpeWwsqv78mQhgfh0avukwgYAxrVWV-JYkNiNen75XsGz0hLnN3nYBhUXzRM_buROQyB_DAlCAV8z0j4gYxSzh2mFRf0C8bcMG5zfmzV-i6KqIPrQBSCiuI8Jo-o0ibk07pF';
    final String url = 'https://fcm.googleapis.com/fcm/send';

    Map<String, dynamic> payload = {
      'notification': {
        'title': title,
        'body': body,
      },
      'registration_ids': fcmTokens,
    };

    final String encodedPayload = json.encode(payload);

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: encodedPayload,
      );
      if (response.statusCode == 200) {
        await addNotificationToCollection();
        titleController.clear();
        descriptionController.clear();
        showToast('Notification sent successfully');
      } else {
        errorToast('Failed to send notification');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }



  Future<void> addNotificationToCollection() async{
    try{
      Map<String,dynamic> notification = {
        "title":titleController.text.trim(),
        "description":descriptionController.text.trim(),
        "timeStamp": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection("Notification")
          .add(notification);
    }
        catch(e){
      debugPrint("Error while adding: $e");
      rethrow;
        }
  }

  // Future<void>sendNotificationToAllUsers() async {
  //   final String serverToken = 'AAAA5hZ0uDs:APA91bHBrpeWwsqv78mQhgfh0avukwgYAxrVWV-JYkNiNen75XsGz0hLnN3nYBhUXzRM_buROQyB_DAlCAV8z0j4gYxSzh2mFRf0C8bcMG5zfmzV-i6KqIPrQBSCiuI8Jo-o0ibk07pF';
  //   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //
  //   final response = await http.post(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=$serverToken',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'to': '/topics/allUsers',
  //         'notification': <String, dynamic>{
  //           'title': 'Hello',
  //           'body': 'This is a notification to all users',
  //         },
  //       },
  //     ),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('Notification sent to all users');
  //   } else {
  //     print('Failed to send notification: ${response.body}');
  //   }
  // }


}