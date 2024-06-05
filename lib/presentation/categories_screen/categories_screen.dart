import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/presentation/filter_screen/controller/filter_controller.dart';
import '../categories_screen/widgets/categories_item_widget.dart';
import 'controller/categories_controller.dart';
import 'models/categories_item_model.dart';

class CategoriesScreen extends StatefulWidget {
   CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoriesController controller = Get.put(CategoriesController());
  FilterController filterController = Get.put(FilterController());

  bool isFilter = false;

  @override
  void initState() {
    // TODO: implement initState
    isFilter = Get.arguments["isFilter"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        backgroundColor: appTheme.bgColor,
        body: SafeArea(
          child: Column(
            children: [
              getCommonAppBar("lbl_categories".tr),
              SizedBox(height: 16.v),
              _buildCategories()
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCategories() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 140.v,
                crossAxisCount: 4,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.h),
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.categoriesData.length,
            itemBuilder: (context, index) {
              CategoriesItemModel model = controller.categoriesData[index];
              return animationfunction(
                  index,
                  CategoriesItemWidget(
                      model,
                      isFilter: isFilter,
                      onTapFootball: () {
                        if(isFilter){

                          filterController.categoryId = model.id;
                          filterController.update();

                        } else {
                          Get.toNamed(
                              AppRoutes.footBallScreen,
                              arguments: {
                                "title" : controller.categoriesData[index].title,
                                "categoryId" : controller.categoriesData[index].id,
                              }
                          );
                        }

                      }
                  ));
            }));
  }

  /// Navigates to the footBallScreen when the action is triggered.
  onTapFootball() {
    Get.toNamed(AppRoutes.footBallScreen);
  }

  /// Navigates to the homeContainerScreen when the action is triggered.
  onTapCategories() {
    Get.toNamed(
      AppRoutes.homeContainerScreen,
    );
  }
}
