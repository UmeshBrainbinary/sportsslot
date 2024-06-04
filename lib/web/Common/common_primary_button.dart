import 'package:flutter/material.dart';
import 'package:sportsslot/theme/theme_helper.dart';
import 'package:sportsslot/web/utils/style_res.dart';


class CommonPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;
  final double? height;
   CommonPrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.textStyle,
    this.color,
    this.textColor,
    this.isLoading, this.height,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 50),
      height: height ?? 37,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
         maximumSize: Size.fromHeight(50),
          backgroundColor: color ?? appTheme.themeColor,
          foregroundColor: appTheme.white,
          padding: EdgeInsets.symmetric(
                  horizontal: 17, vertical: isLoading == true ? 12 : 19)
              .copyWith(bottom: isLoading == true ? 12 : 19),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: appTheme.themeColor, width: 1)),
        ),
        onPressed: () {
          if (isLoading == true) {
          } else {
            if (onTap != null) {
              onTap!();
            }
          }
        },
        child: isLoading == true
            ? SizedBox(
          width: 25,
          height: 25,
              child: Center(
                  child: CircularProgressIndicator(
                    color: textColor ?? appTheme.white,
                  ),
                ),
            )
            : Text(
                text,
                style: textStyle ??
                    semiBoldFontStyle(
                      height: 0.85,
                        size: 16, color: textColor ?? appTheme.white),
              ),
      ),
    );
  }
}
