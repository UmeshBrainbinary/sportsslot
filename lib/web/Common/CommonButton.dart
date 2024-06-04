import 'package:flutter/material.dart';
import 'package:sportsslot/theme/theme_helper.dart';

class CommonButton extends StatelessWidget {
  CommonButton({Key? key, required this.name, this.onTap}) : super(key: key);
  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(color: appTheme.themeColor, borderRadius: BorderRadius.circular(10)),
      height: screenSize.height / 14,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: appTheme.themeColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: onTap,
        child: Text(
          name,
          style: TextStyle(fontSize: 16, color: appTheme.white),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  SmallButton({super.key, required this.name, this.onTap});

  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.themeColor,
          foregroundColor: appTheme.white,
          padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: onTap,
      child: Text(name),
    );
  }
}
