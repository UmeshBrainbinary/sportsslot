import 'package:flutter/material.dart';
import 'package:sportsslot/theme/theme_helper.dart';


class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: appTheme.buttonColor,
      ),
    );
  }
}
