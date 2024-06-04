import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/model/sport_icon_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';




class LogoIconController extends GetxController {
  RxBool loader = false.obs;
  RxString imagePath = "".obs;
  TextEditingController nameController = TextEditingController();
  RxList<SportIconModel> sportIconList = <SportIconModel>[].obs;
  RxList<bool> isHover = <bool>[].obs;
  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    sportIconList.value =  await getSportIcons();
    sportIconList.refresh();
    isHover.value = List.generate(sportIconList.value.length, (index) => false);
    isHover.refresh();
  }

  Future<List<String>> uploadImagesToFirebaseStorage(
      {required List<String> base64Images}) async {
    loader.value = true;
    List<String> downloadUrls = [];

    try {
      for (final String base64Image in base64Images) {
        String base64Data =
            base64Image.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
        final String fileName =
            'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

        List<int> bytes = base64Decode(base64Data);

        Reference storageReference = FirebaseStorage.instance
            .ref(Keys.admin)
            .child(Keys.sportIcon)
            .child('images/$fileName');

        UploadTask uploadTask =
            storageReference.putData(Uint8List.fromList(bytes));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
        print(downloadUrl);
      }

      loader.value = false;
      return downloadUrls;
    } catch (error) {
      print("Error uploading images: $error");
      errorToast("Error uploading image");
      loader.value = false;
      return [];
    }
  }

  Future<void> uploadSportIcon(
      {required List<String> base64Images,
      required VoidCallback onSuccess,required BuildContext context}) async {
    try {
      loader.value = true;
      String id = nameController.text.trim().toLowerCase();


        if(sportIconList.value.any((element) => element.name.toLowerCase() == nameController.text.trim().toLowerCase()))
        {
          errorToast("Sport & Icon already exists");
        }
        else{
          Navigator.pop(context);
          List<String?> imgUrl = await uploadImagesToFirebaseStorage(base64Images: base64Images);
          if (imgUrl.isNotEmpty) {
            CollectionReference  sportIconRef = FirebaseFirestore.instance.collection(Keys.admin).doc(Keys.sportIcon).collection(Keys.sportIcon);
            DocumentReference  docRef = sportIconRef.doc();
            QuerySnapshot querySnapshot = await sportIconRef.where(Keys.id,isEqualTo: id).get();
            SportIconModel sportIconData = SportIconModel(
                name: nameController.text.trim(),
                image: imgUrl.first!,
                timestamp: DateTime.now(), id: docRef.id);

            await docRef.set(sportIconData.toMap());
            // await FirebaseFirestore.instance
            //     .collection(Keys.admin)
            //     .doc(Keys.sportIcon)
            //     .collection(Keys.sportIcon)
            //     .doc()
            //     .set(sportIconData.toMap());
            onSuccess();
            await init();
          }

        }
      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("upload error -------->>>>: $e");
      errorToast("Error while uploading image");
    }
  }


  Future<void> updateSportIcon({
    required List<String> base64Images,
    required bool isFromUpdate,
    required String id,
    required VoidCallback onSuccess,
    required BuildContext context,
  }) async {
    try {
      loader.value = true;

      if(sportIconList.value.any((element) => element.name.toLowerCase() == nameController.text.trim().toLowerCase() && element.id != id))
        {
          errorToast("Sport & Icon already exists");
        }
      else{
Navigator.pop(context);
        List<String?> imgUrl = [];
        if (base64Images.first.contains("https://") && imagePath.value.isEmpty) {
          imgUrl = base64Images;
        } else {
          imgUrl = await uploadImagesToFirebaseStorage(base64Images:imagePath.value.isEmpty ? base64Images : [imagePath.value]);
        }

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(Keys.admin)
            .doc(Keys.sportIcon)
            .collection(Keys.sportIcon)
            .where(Keys.id, isEqualTo: id)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot doc = querySnapshot.docs.first;
          String docId = doc.id;

          SportIconModel sportIconData = SportIconModel(
            name:  nameController.text.trim(),
            image: imgUrl.first!,
            timestamp: DateTime.now(), id: id,
          );

          await doc.reference.update(sportIconData.toMap());

          onSuccess();
          await init();
        } else {
          errorToast("No sport & icon found with the provided name");
        }

      }






      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("Update error -------->>>>: $e");
    }
  }




  Future<List<SportIconModel>> getSportIcons() async {
    List<SportIconModel> sportIcons = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc(Keys.sportIcon)
          .collection(Keys.sportIcon)
      .orderBy("timestamp",descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          SportIconModel sportIcon = SportIconModel.fromMap(data);
          sportIcons.add(sportIcon);
        }
      }
    } catch (e) {
      log("Error fetching sport icons: $e");
    }
    return sportIcons;
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

  Future<void> deleteSportIconByName({
    required String id,
    required VoidCallback onSuccess,
    required final String url,
  }) async {
    try {
      loader.value = true;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc(Keys.sportIcon)
          .collection(Keys.sportIcon)
          .where(Keys.id, isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Delete the document
        await querySnapshot.docs.first.reference.delete();
        await deleteFileFromFirebaseStorage(url);
        await init();
        onSuccess();
      } else {
        errorToast("No sport & icon found with the provided name");
      }

      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("Delete error -------->>>>: $e");
    }
  }



}
