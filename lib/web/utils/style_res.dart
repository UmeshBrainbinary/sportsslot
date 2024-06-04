import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:sportsslot/core/utils/Wrb_font_Family/Font_family.dart';
import 'package:sportsslot/theme/theme_helper.dart';

TextStyle thinFontStyle(
    {double? size,
    String? family,
    Color? color,
    SizingInformation? sizingInformation}) {
  return TextStyle(
      fontSize: size != null && sizingInformation != null
          ? sizingInformation.isMobile
              ? size / 1.9
              : sizingInformation.isTablet
                  ? size / 1.4
                  : size
          : size != null && sizingInformation == null
              ? size
              : size ?? 12,
      fontFamily: family,
      fontWeight: FontWeight.w300,
      // color: color ?? appTheme.black
  );
}

TextStyle regularFontStyle(
    {double? size,
    String? family,
    Color? color,
    double? height,
    // bool? underLine,
    SizingInformation? sizingInformation}) {
  return TextStyle(
      fontSize: size != null && sizingInformation != null
          ? sizingInformation.isMobile
          ? size / 1.9
          : sizingInformation.isTablet
          ? size / 1.4
                  : size
          : size != null && sizingInformation == null
              ? size
              : size ?? 12,
      fontFamily: family ?? Family.robotRegular,
      fontWeight: FontWeight.w400,
      height: height,
      // shadows:
      // underLine == true
      //     ? [Shadow(color: color ?? appTheme.black, offset: Offset(0, -5))]
      //     : null,
      // decoration: underLine == true ? TextDecoration.underline : null,
      color: color

  );
}

TextStyle mediumFontStyle(
    {double? size,
    String? family,
    Color? color,
    double? height,
    // bool? underLine,
    SizingInformation? sizingInformation}) {
  return TextStyle(
      fontSize: size != null && sizingInformation != null
          ? sizingInformation.isMobile
          ? size / 1.9
          : sizingInformation.isTablet
          ? size / 1.4
                  : size
          : size != null && sizingInformation == null
              ? size
              : size ?? 12,
      // shadows: underLine == true
      //     ? [Shadow(color: color ?? appTheme.black, offset: Offset(0, -5))]
      //     : null,
      fontFamily: family ?? Family.robotMedium,
      fontWeight: FontWeight.w500,
      height: height,
      // decoration: underLine == true ? TextDecoration.underline : null,
      color: color
              );
}

TextStyle semiBoldFontStyle(
    {double? size,
    String? family,
    Color? color,
      double? height,
    SizingInformation? sizingInformation}) {
  return TextStyle(
      fontSize: size != null && sizingInformation != null
          ? sizingInformation.isMobile
          ? size / 1.9
          : sizingInformation.isTablet
          ? size / 1.4
                  : size
          : size != null && sizingInformation == null
              ? size
              : size ?? 12,
      fontFamily: family ?? Family.robotMedium,
      fontWeight: FontWeight.w600,
    height: height,
    color: color
  );
}

TextStyle boldFontStyle(
    {double? size,
    String? family,
    Color? color,
    SizingInformation? sizingInformation}) {
  return TextStyle(
      fontSize: size != null && sizingInformation != null
          ? sizingInformation.isMobile
          ? size / 1.9
          : sizingInformation.isTablet
          ? size / 1.4
                  : size
          : size != null && sizingInformation == null
              ? size
              : size ?? 12,
      fontFamily: family ?? Family.robotBold,
      fontWeight: FontWeight.w700,
      color: color ?? appTheme.black);
}


errorTextStyle() {
  return regularFontStyle(
    color: appTheme.red700,
    size: 15,
  );
}
