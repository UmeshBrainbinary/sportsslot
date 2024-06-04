import 'package:flutter/material.dart';
import 'package:sportsslot/theme/theme_helper.dart';

import 'package:sportsslot/web/utils/style_res.dart';


class CustomAddButton extends StatelessWidget {
  const CustomAddButton({
    super.key,
    required this.onTap, required this.text
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 9).copyWith(left: 6.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: appTheme.themeColor,
          elevation: 0,
        ),
        onPressed: onTap,
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: appTheme.white,
              size: 17,
            ),
            Text(
              text,
              style: regularFontStyle(
                  size: 14, color: appTheme.white),
            ),
          ],
        ),
      ),
    );
  }
}