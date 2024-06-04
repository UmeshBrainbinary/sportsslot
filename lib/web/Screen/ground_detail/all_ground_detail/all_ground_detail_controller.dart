import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';

class AllGroundDetailController extends GetxController{

RxBool loader = false.obs;
  List<Map<String, dynamic>> data = [
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
    {'image' : AssetRes.groundPhoto, 'title' : 'Lalbhai Stadium'},
  ];

  RxList<GroundDetailModel> groundDetailList = <GroundDetailModel>[].obs;
  RxList<bool> isHover = <bool>[].obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }
  Future<void> init() async {
    groundDetailList.value =  await getGroundDetailsData();
    groundDetailList.refresh();
    isHover.value = List.generate(groundDetailList.value.length, (index) => false);
    isHover.refresh();
  }

  Future<List<GroundDetailModel>> getGroundDetailsData() async {
    List<GroundDetailModel> groundDetails = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc(Keys.groundDetails)
          .collection(Keys.groundDetails)
          .orderBy("timestamp",descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          GroundDetailModel groundDetailModel = GroundDetailModel.fromMap(data);
          groundDetails.add(groundDetailModel);
        }
      }
    } catch (e) {
      log("Error fetching sport icons: $e");
    }
    return groundDetails;
  }


Future<void> deleteGroundByName({
  required GroundDetailModel data,
  required VoidCallback onSuccess,
}) async {
  try {
    loader.value = true;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Keys.admin)
        .doc(Keys.groundDetails)
        .collection(Keys.groundDetails)
        .where("timestamp", isEqualTo: data.timestamp)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await querySnapshot.docs.first.reference.delete();
      for(var image in data.mainGround?.image ?? [])
        {
          await deleteFileFromFirebaseStorage(image);
        }
      for(SubGround data in data.subGrounds ??[])
      {
        for(String img in data.image ??[])
          {
            await deleteFileFromFirebaseStorage(img);
          }
      }
      await init();
      onSuccess();
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