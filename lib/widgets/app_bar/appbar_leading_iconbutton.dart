import 'package:flutter/material.dart';

import 'package:sportsslot/core/utils/image_constant.dart';
import 'package:sportsslot/core/utils/size_utils.dart';
import 'package:sportsslot/widgets/custom_icon_button.dart';
import 'package:sportsslot/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class AppbarLeadingIconbutton extends StatelessWidget {
  AppbarLeadingIconbutton({
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
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 48.adaptSize,
          width: 48.adaptSize,
          decoration: IconButtonStyleHelper.fillOnErrorContainer,
          child: CustomImageView(
            imagePath: ImageConstant.imgGroup1171274870,
          ),
        ),
      ),
    );
  }
}
