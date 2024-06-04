import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';

class CommonEditDeletePopup extends StatelessWidget {
  final onTapEdit;
  final onTapDelete;
  final Offset? offset;
  final String? editArgs;
   CommonEditDeletePopup({super.key, required this.onTapEdit, required this.onTapDelete,  this.offset, this.editArgs});

  ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return   PopupMenuButton(
        padding: EdgeInsets.symmetric(horizontal: 2.5,vertical: 9),
        elevation: 6,
        color: themeController.c.value,//appTheme.white,
        surfaceTintColor: appTheme.white,
        // position: PopupMenuPosition.over,
          splashRadius: 8,
        constraints: BoxConstraints(maxWidth: 205),

        offset: offset ?? Offset(0, 35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: Image(
            width: 20,
            height: 20,
            image: AssetImage(AssetRes.dot)),
        itemBuilder: (context) => [
          PopupMenuItem(height: 40,
            onTap:onTapEdit,
            child: Container(
              height: 40,
              margin: EdgeInsets.only(top: 4,bottom: 4),
              padding: EdgeInsets.only(top: 3, bottom: 3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  color: themeController.c.value
                //appTheme.colorF7F9FF
              ),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  ImageIcon(
                    color: themeController.blueIcon.value,
                    size: 22,
                    AssetImage("assets/web/icons/Edit_Pencil_01.png"),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Edit $editArgs',
                    style: regularFontStyle(color: themeController.blueIcon.value,size: 14),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            height: 39,
            onTap: onTapDelete,
            child: Container(
              height: 39,
              margin: EdgeInsets.only(top:8.5,bottom: 4),
              padding: EdgeInsets.only(top: 3, bottom: 3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color:
               themeController.c.value
              //appTheme.colorFEF3F5
              ),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  ImageIcon(
                    color: themeController.redIcon.value,
                    size: 22,
                    AssetImage("assets/web/icons/Trash_Full.png"),
                  ),
                  SizedBox(width: 8),
                  Text('Delete $editArgs', style: regularFontStyle(size: 14,color: themeController.redIcon.value))
                ],
              ),
            ),
          ),
        ],
      );

  }
}
