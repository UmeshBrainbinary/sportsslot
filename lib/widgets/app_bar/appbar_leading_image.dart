import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportsslot/core/utils/size_utils.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/widgets/custom_image_view.dart';


// ignore: must_be_immutable
class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Get.back();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(

          color: appTheme.black900,
          imagePath: imagePath,
          height: 24.adaptSize,
          width: 24.adaptSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
