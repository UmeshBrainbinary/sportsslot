import 'package:flutter/material.dart';
import 'package:sportsslot/theme/custom_text_style.dart';
import 'package:sportsslot/theme/theme_helper.dart';

// ignore: must_be_immutable
class AppbarSubtitleOne extends StatelessWidget {
  AppbarSubtitleOne({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

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
        child: Text(
          text,
          style: CustomTextStyles.bodyLargeSecondaryContainer.copyWith(
            color: theme.colorScheme.secondaryContainer,
          ),
        ),
      ),
    );
  }
}
