import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/model/event_detail_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';

class AllEventDetailController extends GetxController{

  RxBool loader = false.obs;
  List<Map<String, dynamic>> data = [
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
    {'image' : AssetRes.basketball, 'title' : 'Basket ball Match'},
  ];


  RxList<EventDetailModel> eventList = <EventDetailModel>[].obs;
  RxList<bool> isHover = <bool>[].obs;
  @override
  void onInit() {
    init();
    super.onInit();
  }


Future<void> init() async {
  eventList.value =  await getEventsRecord();
  eventList.refresh();
  isHover.value = List.generate(eventList.value.length, (index) => false);
  isHover.refresh();
}


  Future<List<EventDetailModel>> getEventsRecord() async {
    List<EventDetailModel> sportIcons = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc(Keys.events)
          .collection(Keys.events)
          .orderBy("timestamp",descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          EventDetailModel sportIcon = EventDetailModel.fromMap(data);
          sportIcons.add(sportIcon);
        }
      }
    } catch (e) {
      log("Error fetching sport icons: $e");
    }
    return sportIcons;
  }

  Future<void> deleteEventData({
    required EventDetailModel data,
    required VoidCallback onSuccess,
  }) async {
    try {
      loader.value = true;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc(Keys.events)
          .collection(Keys.events)
          .where("timestamp", isEqualTo: data.timestamp)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
       for(String image in data.eventImages)
         {
           await deleteFileFromFirebaseStorage(image);
         }
        for(String image in data.preMemoryImages)
        {
          await deleteFileFromFirebaseStorage(image);
        }

        onSuccess();
        await init();
      } else {
        errorToast("Something went wrong");
        // errorToast("No sport & icon found with the provided name");
      }

      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("Delete error -------->>>>: $e");
    }
  }



  Future<void> deleteFileFromFirebaseStorage(String url) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
      print('File deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}