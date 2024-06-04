import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsslot/web/helper/theme/theme_helper.dart';

import 'package:sportsslot/web/service/pref_service.dart';
import 'package:sportsslot/web/utils/pref_keys.dart';


class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = PrefService.getBool(PrefKeys.isDarkTheme);
    setThemeWiseColor();
  }

  Future<void> saveThemeToBox(bool isDarkMode) async{
    await PrefService.setValue(PrefKeys.isDarkTheme, isDarkMode);
  }

  void switchTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    saveThemeToBox(isDarkMode.value);
    setThemeWiseColor();
  }


  Rx<Color> dividerColor = appTheme.colorCECECF.obs;
  Rx<Color> drawerBgColor = appTheme.white.obs;
  Rx<Color> bgColor = appTheme.white.obs;
  Rx<Color> textfieldBgColor = appTheme.white.obs;
  Rx<Color> hintColor = appTheme.white.obs;
  Rx<Color> webBgColor = appTheme.white.obs;
  Rx<Color> c = appTheme.white.obs;
  Rx<Color> d = appTheme.white.obs;
  Rx<Color> cancel = appTheme.white.obs;
  Rx<Color> blueIcon = appTheme.blueIcon.obs;
  Rx<Color> redIcon = appTheme.redIcon.obs;
  Rx<Color> toolbarIconColor = appTheme.white.obs;
  Rx<Color> deleteBgColor = appTheme.white.obs;


  void setThemeWiseColor() {
    if(isDarkMode.value)
      {
        drawerBgColor.value = appTheme.color1B1B1B;
        bgColor.value = appTheme.color151515;
        textfieldBgColor.value = appTheme.color2D2D2D;
        hintColor.value = appTheme.colorA7A7A7;
        webBgColor.value = appTheme.color151515;
        c.value = appTheme.darkgray;
        d.value = appTheme.white;
        blueIcon.value = appTheme.white;
        redIcon.value = appTheme.white;
        toolbarIconColor.value = appTheme.white;
        deleteBgColor.value = Color(0xFF443839);
      }
    else{
      drawerBgColor.value = appTheme.white;
      bgColor.value = appTheme.white;
      textfieldBgColor.value = appTheme.textfieldFillColor;
      hintColor.value = appTheme.dotted;
      webBgColor.value = appTheme.webBgColor;
      c.value = appTheme.white;
      d.value = appTheme.darkgray;
      blueIcon.value = appTheme.blueIcon;
      redIcon.value = appTheme.redIcon;
      toolbarIconColor.value = appTheme.black;
      deleteBgColor.value = appTheme.colorFEF3F5;
    }
  }

}
