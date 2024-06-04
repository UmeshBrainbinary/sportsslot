import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';



class CommonTextFiled extends StatelessWidget {
  CommonTextFiled(
      {Key? key,
        this.icon,
        this.onsave,
        this.maxLine,
        this.keyboardType,
        this.icons,
        this.hintHeight,
        this.readOnly,
        this.suffixIcon,
        this.obscureText,
        this.enable,
        this.validation,
        required this.hintext,
        this.onChange,
        this.textHeight,
        this.msg,
        this.inputFormatter,
        this.onTap,
        this.contentPadding,
        this.controller,
        this.width
      })
      : super(key: key);
  IconData? icons;
  final String hintext;
  var onChange;
  TextInputType? keyboardType;
  String? msg;
  Widget? suffixIcon;
  int? maxLine;
  bool? obscureText;
  double? hintHeight;
  double? textHeight;
  bool? readOnly;
  bool? enable;
  List<TextInputFormatter>? inputFormatter;
  EdgeInsets? contentPadding;
  var onTap;
  var controller;
  var onsave;
  IconData? icon;
  double? width;

  var validation;

ThemeController themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height:maxLine != null && ((maxLine ?? 0) < 2) ? 45 : null,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color:themeController.textfieldBgColor.value,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          readOnly: readOnly ?? false,
          enabled: enable,
          validator: validation,
          controller: controller,
          onTap: onTap,
          maxLines: maxLine ?? 1,
          inputFormatters: inputFormatter,
          onChanged: onChange,
          style:  regularFontStyle(size:(maxLine ?? 0) < 10 ? 15 : 18,height: textHeight ?? 0.8),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintStyle: regularFontStyle(size:  (maxLine ?? 0) < 10 ? 15 : 18,color:themeController.hintColor.value,height: hintHeight),
            contentPadding:contentPadding != null ? contentPadding : (maxLine ?? 0) < 2  ?
            EdgeInsets.symmetric(horizontal: 16):EdgeInsets.symmetric(horizontal: 22,vertical: 19),
            border: InputBorder.none,
            hintText: hintext,
          ),
        ),

    );
  }
}
