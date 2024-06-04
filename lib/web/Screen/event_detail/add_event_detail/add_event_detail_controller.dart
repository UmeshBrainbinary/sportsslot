import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/Common/common_methods.dart';
import 'package:sportsslot/web/Screen/event_detail/all_event_detail/all_event_detail_controller.dart';
import 'package:sportsslot/web/model/event_detail_model.dart';
import 'package:sportsslot/web/service/pref_service.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';
import 'package:sportsslot/web/utils/pref_keys.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddEventDetailController extends GetxController {
  final EventDetailModel? data;
  AddEventDetailController({this.data});


  RxBool loader = false.obs;
  RxList<String> eventImgList = <String>[].obs;
  RxList<String> preMemoryImgList = <String>[].obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController entryFeeController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  AllEventDetailController eventController = Get.find<AllEventDetailController>();
  RxString eventNameError = "".obs;
  RxString dateError = "".obs;
  RxString timeError = "".obs;
  RxString entryFeeError = "".obs;
  RxString eventImgError = "".obs;
  RxString preMemoryImgError = "".obs;
  RxString descriptionError = "".obs;
  RxString urlError = "".obs;


  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString selectedStartDate = "".obs;
  RxString selectedEndDate = "".obs;
  String? formattedTime;
  DateTime timeStampForUpdate = DateTime.now();
  Future<void> selectStartDate(BuildContext context,{DateTime? startDateU}) async {
    final DateTime? picked =
        await showCommonDatePicker(context: context, initDate: startDate.value,isFutureOnly: true,startDate: startDateU);
    if (picked != null && picked != startDate.value) {
      if (selectedEndDate.value.isNotEmpty) {
        if (picked.isBefore(DateFormat("dd/MM/yyyy").parse(selectedEndDate.value)) || DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(picked)) == (DateFormat("dd/MM/yyyy").parse(selectedEndDate.value)) ) {
          startDate.value = picked;
          selectedStartDate.value = DateFormat("dd/MM/yyyy").format(picked);
        } else {
          errorToast("invalidDateRange".tr);
        }
      } else {
        startDate.value = picked;
        selectedStartDate.value = DateFormat("dd/MM/yyyy").format(picked);
      }
    }
  }

  Future<void> selectEndDate(BuildContext context,{DateTime? startDateU}) async {
    DateTime? picked =
        await showCommonDatePicker(context: context, initDate: endDate.value,isFutureOnly: true,startDate: startDateU);
    if (picked != null && picked != endDate.value) {
      if (selectedStartDate.value.isNotEmpty) {
        if (picked.isAfter(DateFormat("dd/MM/yyyy").parse(selectedStartDate.value)) || DateFormat("dd/MM/yyyy").parse(DateFormat("dd/MM/yyyy").format(picked)) == (DateFormat("dd/MM/yyyy").parse(selectedStartDate.value))) {
          endDate.value = picked;
          selectedEndDate.value = DateFormat("dd/MM/yyyy").format(picked);
        } else {
          errorToast("invalidDateRange".tr);
        }
      } else {
        endDate.value = picked;
        selectedEndDate.value = DateFormat("dd/MM/yyyy").format(picked);
      }
    }
  }

  Future<String?> timePicker(
      {required BuildContext context, required int type}) async {
    var selectedTime = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: TextTheme(
              // bodyText1: TextStyle(color: themeController.d.value,),
              // bodyText2: TextStyle(color: themeController.d.value,),

            ),
            colorScheme: PrefService.getBool(PrefKeys.isDarkTheme) == false
                ? ColorScheme.light(
              primary:  appTheme.themeColor,
              onPrimary: Colors.white,
            ) : ColorScheme.dark(
              primary:  appTheme.themeColor,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[900],

          ), child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (selectedTime != null) {
      String formattedTime = DateFormat('hh:mm a').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      ));

      if (type == 0) {
        if (toTimeController.text.isNotEmpty) {
          DateTime toTime = DateFormat('hh:mm a').parse(toTimeController.text);
          DateTime selectedDateTime =
              DateFormat('hh:mm a').parse(formattedTime);

          if (selectedDateTime.isBefore(toTime)) {
            fromTimeController.text = formattedTime;
            return formattedTime;
          } else {
            errorToast("To time must be later than from time");
          }
        } else {
          fromTimeController.text = formattedTime;
          return formattedTime;
        }
      } else {
        if (fromTimeController.text.isNotEmpty) {
          DateTime fromTime =
              DateFormat('hh:mm a').parse(fromTimeController.text);
          DateTime selectedDateTime =
              DateFormat('hh:mm a').parse(formattedTime);

          if (selectedDateTime.isAfter(fromTime)) {
            toTimeController.text = formattedTime;
            return formattedTime;
          } else {
            errorToast("To time must be later than from time");
          }
        } else {
          toTimeController.text = formattedTime;
          return formattedTime;
          // errorToast("Please select a from time first");
        }
      }
    }
    return null;
  }


 void checkAllFieldValidation() {

    if (nameController.text.trim().isEmpty) {
      eventNameError.value = "Please enter event name";
    } else {
      eventNameError.value = "";
    }
    if (selectedStartDate.value.isEmpty || selectedEndDate.value.isEmpty) {
      dateError.value = "Please select date range";
    } else {
      dateError.value = "";
    }
    // if (fromTimeController.text.trim().isEmpty ||
    //     toTimeController.text.trim().isEmpty) {
    //   timeError.value = "Please select time range";
    // } else {
    //   timeError.value = "";
    // }
    if (entryFeeController.text.trim().isEmpty) {
      entryFeeError.value = "Please enter entry fee";
    } else {
      entryFeeError.value = "";
    }
    if (descriptionController.text.trim().isEmpty) {
      descriptionError.value = "Please enter description";
    } else {
      descriptionError.value = "";
    }
    if (urlController.text.trim().isEmpty) {
      urlError.value = "Please enter location url";
    }
    else if (!urlController.text.contains("https://")) {
      urlError.value = "Please enter valid location url";
    }
    else {
      urlError.value = "";
    }
    if (eventImgList.value.isEmpty) {
      eventImgError.value = "Please select event image";
    } else {
      eventImgError.value = "";
    }
    if (preMemoryImgList.value.isEmpty) {
      preMemoryImgError.value = "Please select previous memory image";
    } else {
      preMemoryImgError.value = "";
    }

  }
 bool validateForm() {


      if (eventNameError.value.isEmpty &&
          dateError.value.isEmpty &&
          // timeError.value.isEmpty &&
          entryFeeError.value.isEmpty &&
          eventImgError.value.isEmpty &&
          urlError.value.isEmpty &&
          preMemoryImgError.value.isEmpty &&
          descriptionError.value.isEmpty) {

        return true;
      } else {

        return false;
      }


  }


  clearData(){
    selectedStartDate.value = "";
    selectedEndDate.value = "";
    nameController.clear();
    descriptionController.clear();
    fromTimeController.clear();
    toTimeController.clear();
    entryFeeController.clear();
    eventImgList.value.clear();
    preMemoryImgList.value.clear();
    eventImgList.refresh();
    preMemoryImgList.refresh();
    eventNameError.value = "";
    dateError.value = "";
    timeError.value = "";
    urlError.value = "";
    entryFeeError.value = "";
    eventImgError.value = "";
    preMemoryImgError.value = "";
    descriptionError.value = "";
  }

  Future<List<String>> uploadImagesToFirebaseStorage(
      {required List<String> base64Images}) async {
    loader.value = true;
    List<String> downloadUrls = [];

    try {
      for (final String image in base64Images) {
        if(image.contains("https://") ){
          downloadUrls.add(image);
        }
        else{
          String base64Data = image.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
          final String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

          List<int> bytes = base64Decode(base64Data);

          Reference storageReference = FirebaseStorage.instance
              .ref(Keys.admin)
              .child(Keys.events)
              .child('images/$fileName');

          UploadTask uploadTask =
          storageReference.putData(Uint8List.fromList(bytes));
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
          print(downloadUrl);
        }

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




  Future<void> deleteFileFromFirebaseStorage(String url) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
      print('File deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }


  Future<void> insertEventDetails(
      {required VoidCallback onSuccess}) async {
    try {
      loader.value = true;
      if(eventController.eventList.value.any((element) => element.name.toLowerCase() == nameController.text.trim().toLowerCase()))
      {
        errorToast("Event already exists");
      }
      else{

        List<String> eventImgUrl =
        await uploadImagesToFirebaseStorage(base64Images: eventImgList.value);

        List<String> preMemoryImgUrl =  await uploadImagesToFirebaseStorage(base64Images: preMemoryImgList.value);
        if (eventImgUrl.isNotEmpty && preMemoryImgUrl.isNotEmpty) {

          EventDetailModel eventDetailData = EventDetailModel(
              name: nameController.text.trim(),
              eventImages: eventImgUrl,
              startDate: startDate.value,
              endDate: endDate.value,
              fromTime:fromTimeController.text.isNotEmpty && toTimeController.text.isNotEmpty ? convertToDateTime(fromTimeController.text) : null,
              toTime: fromTimeController.text.isNotEmpty && toTimeController.text.isNotEmpty ? convertToDateTime(toTimeController.text) : null,
              preMemoryImages: preMemoryImgUrl,
              price: double.tryParse(entryFeeController.text.trim()) ?? 0.0,
              timestamp: DateTime.now(),
              description: descriptionController.text.trim(), url: urlController.text.trim());


          await FirebaseFirestore.instance
              .collection(Keys.admin)
              .doc(Keys.events)
              .collection(Keys.events)
              .doc()
              .set(eventDetailData.toMap());
          await eventController.init();
          await clearData();
          onSuccess();

        }
      }


      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("upload error -------->>>>: $e");
    }
  }

  Future<void> updateEventDetails(
      {required VoidCallback onSuccess}) async {
    try {
      loader.value = true;
      if(eventController.eventList.value.any((element) => element.name.toLowerCase() == nameController.text.trim().toLowerCase() && element.timestamp != timeStampForUpdate))
      {
        errorToast("Event already exists");
      }
      else{
        for(int i=0; i<data!.eventImages.length;i++)
        {
          if(!(eventImgList.value.any((element) => data!.eventImages[i] == element)))
          {
            await deleteFileFromFirebaseStorage(data!.eventImages[i]);
            debugPrint("File deleted ---------------------");
          }
        }
        for(int i=0; i<data!.preMemoryImages.length;i++)
        {
          if(!(preMemoryImgList.value.any((element) => data!.preMemoryImages[i] == element)))
          {
            await deleteFileFromFirebaseStorage(data!.preMemoryImages[i]);
            debugPrint("File deleted ---------------------");
          }
        }

        List<String> eventImgUrl = await uploadImagesToFirebaseStorage(base64Images: eventImgList.value);
        List<String> preMemoryImgUrl =  await uploadImagesToFirebaseStorage(base64Images: preMemoryImgList.value);


        if (eventImgUrl.isNotEmpty && preMemoryImgUrl.isNotEmpty) {
          EventDetailModel eventDetailData = EventDetailModel(
              name: nameController.text.trim(),
              eventImages: eventImgUrl,
              startDate: startDate.value,
              endDate: endDate.value,
              fromTime:fromTimeController.text.isNotEmpty && toTimeController.text.isNotEmpty ? convertToDateTime(fromTimeController.text) : null,
              toTime:fromTimeController.text.isNotEmpty && toTimeController.text.isNotEmpty ? convertToDateTime(toTimeController.text) : null,
              preMemoryImages: preMemoryImgUrl,
              price: double.tryParse(entryFeeController.text.trim()) ?? 0.0,
              timestamp: DateTime.now(),
              description: descriptionController.text.trim(), url: urlController.text.trim());

          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection(Keys.admin)
              .doc(Keys.events)
              .collection(Keys.events)
              .where(Keys.timestamp, isEqualTo: data!.timestamp)
              .get();
          debugPrint("------------: ${querySnapshot.docs.first.data()}");
          if (querySnapshot.docs.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection(Keys.admin)
                .doc(Keys.events)
                .collection(Keys.events).doc(querySnapshot.docs.first.id)
                .update(eventDetailData.toMap());
            onSuccess();
            await eventController.init();
            await clearData();
          } else {
            errorToast("Stadium details not found");
          }
        }
      }


      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("upload error -------->>>>: $e");
    }
  }



  DateTime convertToDateTime(String timeString) {
    DateTime now = DateTime.now();
    DateTime timeOfDay = DateFormat('hh:mm a').parse(timeString);

    return DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }



  void setDateOnEdit(){
    if(data != null)
      {
        selectedStartDate.value = DateFormat("dd/MM/yyyy").format(data!.startDate);
        selectedEndDate.value = DateFormat("dd/MM/yyyy").format(data!.endDate);
        startDate.value = data!.startDate;
        endDate.value = data!.endDate;
        nameController.text = data!.name;
        descriptionController.text = data!.description;
        urlController.text = data?.url ?? "";
        fromTimeController.text =data?.fromTime != null ? DateFormat("hh:mm a").format(data!.fromTime!) : "";
        toTimeController.text =data?.fromTime != null ? DateFormat("hh:mm a").format(data!.toTime!):"";
        entryFeeController.text = data!.price.toStringAsFixed(2);
        eventImgList.value = data!.eventImages;
        preMemoryImgList.value = data!.preMemoryImages;
        eventImgList.refresh();
        preMemoryImgList.refresh();
        timeStampForUpdate = data!.timestamp;
      }
  }
}
