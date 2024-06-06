import 'package:sportsslot/presentation/filter_screen/controller/filter_controller.dart';

import '../controller/categories_controller.dart';
import '../models/categories_item_model.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';

// ignore: must_be_immutable
class CategoriesItemWidget extends StatelessWidget {
  CategoriesItemWidget(this.categoriesItemModelObj, {Key? key, this.onTapFootball, required this.isFilter}
      ) : super(key: key);

  CategoriesItemModel categoriesItemModelObj;



  VoidCallback? onTapFootball;
  bool isFilter;

  var controller = Get.find<CategoriesController>();

  var filterController = Get.find<FilterController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(

        builder: (controller) {
      return GestureDetector(
        onTap: () {
          onTapFootball!.call();
        },
        child: Container(
          height: 50.v,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              border: Border.all(color: (isFilter && filterController.categoryId == categoriesItemModelObj.id) ? appTheme.themeColor : appTheme.boxBorder)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    categoriesItemModelObj.title!,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: (isFilter && filterController.categoryId == categoriesItemModelObj.id) ? appTheme.buttonColor : appTheme.black900,
                      fontFamily: 'Montserrat-Medium',
                    )
                ),
                SizedBox(width: 10.v),
                Container(
                    height: 35.adaptSize,
                    width: 35.adaptSize,
                    decoration: AppDecoration.fillOrange.copyWith(
                      //color: categoriesItemModelObj.bgColor,
                      borderRadius: BorderRadiusStyle.roundedBorder42,
                    ),
                    child: CustomImageView(
                      radius: BorderRadius.circular(45),
                      imagePath: categoriesItemModelObj.icon,
                      height: 85.adaptSize,
                      width: 85.adaptSize,
                      alignment: Alignment.center,
                    )
                ),
              ],
            ),
          )
        ),
      );
    });





  }
}
