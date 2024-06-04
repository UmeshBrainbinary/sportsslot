import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/web/Common/custom_switch.dart';
import 'package:sportsslot/web/Common/dialog/logout_dialog.dart';
import 'package:sportsslot/web/Screen/about/about_screen.dart';
import 'package:sportsslot/web/Screen/booking_history/booking_history_screen.dart';
import 'package:sportsslot/web/Screen/dashboard/dashboard_controller.dart';
import 'package:sportsslot/web/Screen/event_detail/all_event_detail/all_event_detail_screen.dart';
import 'package:sportsslot/web/Screen/faqs/faq_screen.dart';
import 'package:sportsslot/web/Screen/ground_detail/all_ground_detail/all_ground_detail_screen.dart';
import 'package:sportsslot/web/Screen/logo_icon/logo_icon_screen.dart';
import 'package:sportsslot/web/Screen/notification/notification_screen.dart';
import 'package:sportsslot/web/Screen/privacy_policy/privacy_policy_screen.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../core/utils/Wrb_font_Family/Font_family.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  final int index;
  const DashboardScreen({super.key, required this.child, required this.index});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController controller = Get.put(DashboardController());
  ThemeController themeController = Get.find<ThemeController>();



  indexWiseNavigation({index}) {
    print("------------------------$index");
    if (index == 0) {
      Get.offAll(
          transition: Transition.noTransition,
          () => DashboardScreen(child: LogoIconScreen(), index: 0));
    } else if (index == 1) {
      Get.offAll(
          transition: Transition.noTransition,
              () => DashboardScreen(child: BookingHistoryScreen(), index: 1));

    } else if (index == 2) {
      Get.offAll(
          transition: Transition.noTransition, () => AllEventDetailScreen());
    } else if (index == 3) {
      Get.offAll(
          transition: Transition.noTransition, () => AllGroundDetailScreen());
    } else if (index == 4) {
      Get.offAll(
          transition: Transition.noTransition,
          () => DashboardScreen(child: NotificationScreen(), index: 4));
    } else if (index == 5) {
      Get.offAll(
          transition: Transition.noTransition,
          () => DashboardScreen(child: PrivacyPolicyScreen(), index: 5));
    } else if (index == 6) {
      Get.offAll(
          transition: Transition.noTransition,
          () => DashboardScreen(child: FaqScreen(), index: 6));
    } else if (index == 7) {
      Get.offAll(
          transition: Transition.noTransition,
          () => DashboardScreen(child: AboutScreen(), index: 7));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.isDesktop) {
          width = 800;
        } else if (sizingInformation.isTablet) {
          width = 550;
        } else if (sizingInformation.isMobile) {
          width = 350;
        }
        return Scaffold(
          backgroundColor: appTheme.white,
          body: Row(
            children: [
              Expanded(
                flex: sizingInformation.isDesktop
                    ? 1
                    : sizingInformation.isTablet
                        ? 2
                        : 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                  child: Column(
                    children: [
                      Image.asset(AssetRes.logo, height: height*0.15),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "PlaygroundBooking".tr,
                        style: semiBoldFontStyle(
                            size: 18, sizingInformation: sizingInformation),
                      ),
                      SizedBox(
                        height: width / 15,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 47,
                            child:
                           index != 8 ?
                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      indexWiseNavigation(index: index);
                                    },
                                    child: Obx(
                                      () =>  Container(
                                        margin: EdgeInsets.symmetric(vertical: 1),
                                        height: 45,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        decoration:themeController.isDarkMode.value ?
                                        BoxDecoration(
                                            color: widget.index == index
                                                ?themeController.webBgColor.value
                                                : Colors.transparent) : BoxDecoration(
                                            color: widget.index == index
                                                ?themeController.webBgColor.value
                                                : Colors.transparent),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            controller.items[index],
                                            textAlign: TextAlign.start,
                                            style: mediumFontStyle(
                                                size: 20,
                                                sizingInformation:
                                                    sizingInformation),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                widget.index == index && index != 8
                                    ? Container(
                                        width: 4,
                                        height: 47,
                                        alignment: Alignment.centerRight,
                                        decoration: BoxDecoration(
                                            color: appTheme.themeColor,
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      )
                                    : SizedBox(),

                              ],
                            ) :
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               GestureDetector(
                                 onTap: () {
                                   indexWiseNavigation(index: index);
                                 },
                                 child: Container(
                                   margin: EdgeInsets.symmetric(vertical: 1),
                                   height: 45,
                                   padding: EdgeInsets.symmetric(
                                       horizontal: 20, vertical: 5),
                                   decoration: BoxDecoration(
                                       color: widget.index == index
                                           ? appTheme.webBgColor
                                           : Colors.transparent),
                                   child: Align(
                                     alignment: Alignment.centerLeft,
                                     child: Text(
                                       controller.items[index],
                                       textAlign: TextAlign.start,
                                       style: mediumFontStyle(
                                           size: 20,
                                           color: Color(0xFF969696),
                                           sizingInformation:
                                           sizingInformation),
                                     ),
                                   ),
                                 ),
                               ),
                               widget.index == index && index != 8
                                   ? Container(
                                 width: 4,
                                 height: 47,
                                 alignment: Alignment.centerRight,
                                 decoration: BoxDecoration(
                                     color: appTheme.themeColor,
                                     borderRadius:
                                     BorderRadius.circular(3)),
                               )
                                   : SizedBox(),
                               index == 8
                                   ?  Obx(
                                     () => CustomSwitch(
                                   value: themeController.isDarkMode.value,
                                   onChanged: (value) {
                                     debugPrint("-=-=-=-=-=-: ${value}");
                                     themeController.isDarkMode.value = value;
                                     themeController.switchTheme();
                                   },
                                 ),
                               )

                                   : SizedBox(),
                             ],
                           ),
                          );
                        },
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showLogoutSuccessDialog(
                              context: context, width: width, height: width);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              SizedBox(width: 18),
                              ImageIcon(
                                AssetImage(AssetRes.logout),
                                color: appTheme.themeColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Family.robotRegular),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                // flex: 5,
                // child: Obx(()=>
                //    controller.screen[controller.currentIndex.value]),
                flex: sizingInformation.isDesktop
                    ? 4
                    : sizingInformation.isTablet
                        ? 6
                        : 8,
                child: widget.child,
              ),
            ],
          ),
        );
      },
    );
  }
}
