import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/presentation/select_date_time_screen/models/select_date_time_model.dart';
import 'package:get/get.dart';


class SelectDateTimeController extends GetxController {
 // List<SelectDateTimeModel> timeData = SelectTimeData.getTimeData();

 RxInt? currentTime;

 DateTime? selectedDate;
 RxString bookingTime = "".obs;
 RxList<SelectDateTimeModel> timeData = <SelectDateTimeModel>[].obs;

 TextEditingController memberController = TextEditingController();

 RxBool isAddBooking = true.obs;
 RxBool loader = false.obs;



  dynamic price;

 String randomCode = '';

 String generateRandomCode(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  String userName = PrefUtils.getString(PrefKey.fullName);
  final random = Random();

  var userNameCode = List.generate(3, (index) => userName[random.nextInt(userName.length)]).join();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join() + userNameCode;
 }








}
