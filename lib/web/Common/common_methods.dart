import 'dart:async';
//import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/service/pref_service.dart';
import 'package:sportsslot/web/utils/pref_keys.dart';
import '../../theme/theme_helper.dart';



void pickImage(RxString imageUrl) {
  // html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  // uploadInput.accept = 'image/jpeg, image/png, image/jpg'; // Accept only jpeg and png files
  // uploadInput.click();
  //
  // uploadInput.onChange.listen((e) {
  //   final files = uploadInput.files;
  //   if (files!.length == 1) {
  //     final file = files[0];
  //     final reader = html.FileReader();
  //     // Check if the file type is accepted
  //     if (file.type == 'image/jpeg' || file.type == 'image/png' ||  file.type == 'image/jpg') {
  //       reader.readAsDataUrl(file);
  //       reader.onLoadEnd.listen((e) {
  //         imageUrl.value = (reader.result as String?) ?? "";
  //       });
  //     } else {
  //       // Show error message for unsupported file types
  //       errorToast("Unsupported file type. Please select a JPEG ,PNG or JPG image.");
  //     }
  //   }
  // });
}




  ThemeController themeController = Get.find<ThemeController>();
class CustomTheme {


  static ThemeData getCustomTheme() {
    return ThemeData.light().copyWith(
      primaryColor: appTheme.themeColor,
      colorScheme: ColorScheme.light(primary: appTheme.themeColor),
      textTheme: TextTheme(
        // bodyText1: TextStyle(color: themeController.d.value),
        // bodyText2: TextStyle(color: themeController.d.value),
      ),
      buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.normal),
      dialogBackgroundColor: Colors.grey[900],
    );
  }
}



Future<List<String>> pickMultiImage({bool? isMultiple}) async {
  // html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  // uploadInput.multiple = true;
  // uploadInput.accept = 'image/jpeg, image/png, image/jpg';
  // uploadInput.click();
  //
  // List<String> imgList = [];
  // final completer = Completer<List<String>>();
  // List<Future<void>> futures = [];
  //
  // uploadInput.onChange.listen((e) {
  //   final files = uploadInput.files;
  //   if (files != null) {
  //     for (var file in files) {
  //       final reader = html.FileReader();
  //       if (file.type == 'image/jpeg' || file.type == 'image/png' || file.type == 'image/jpg') {
  //         final fileLoadFuture = reader.onLoadEnd.first.then((e) {
  //           imgList.add((reader.result as String?) ?? "");
  //         });
  //
  //         futures.add(fileLoadFuture);
  //         reader.readAsDataUrl(file);
  //       } else {
  //         errorToast("Unsupported file type. Please select only JPEG, PNG, or JPG images.");
  //       }
  //     }
  //   }
  //
  //   Future.wait(futures).then((_) => completer.complete(imgList));
  // });

  //return completer.future;
  return [];
}



class CustomInputFormatterNumberOnly extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'^[0-9.]*$|^([0-9]+[.][0-9]*)([eE][-+]?[0-9]+)?$');
    if (!regExp.hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}



//
class CustomInputFormatterTextOnly extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'^[a-zA-Z\s]*$');
    if (!regExp.hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}



Future<DateTime?> showCommonDatePicker(
    {required BuildContext context, DateTime? initDate,bool? isFutureOnly,DateTime? startDate}) async {

  ThemeController themeController = Get.find<ThemeController>();

  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: initDate ?? DateTime.now(),
    firstDate:startDate != null ? startDate : isFutureOnly == true ? DateTime.now() : DateTime(2000),
    lastDate: DateTime(2050) ,
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

        ),
        child: child!,
      );
    },
  );
  return date;
}




String generateTimestampId() {
  Timestamp timestamp = Timestamp.now();
  int microsecondsSinceEpoch = timestamp.microsecondsSinceEpoch;
  return microsecondsSinceEpoch.toString();
}