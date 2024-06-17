// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/onboarding_one_controller.dart';
import 'models/eightyeight_item_model.dart';

class OnboardingOneScreen extends StatefulWidget {
  const OnboardingOneScreen({super.key});

  @override
  State<OnboardingOneScreen> createState() => _OnboardingOneScreenState();
}

class _OnboardingOneScreenState extends State<OnboardingOneScreen> {
  OnboardingOneController onboardingOneController =
      Get.put(OnboardingOneController());

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async{
        closeApp();
        return false;
      },
      child: Scaffold(
          backgroundColor: appTheme.secondarybgcolor,
          body: GetBuilder<OnboardingOneController>(
            init: OnboardingOneController(),
            builder: (controller) => Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              itemCount: controller.onboardingList.length,
              onPageChanged: (value) {
                controller.setCurrentPage(value);
              },
              itemBuilder: (context, index) {
                EightyeightItemModel data = controller.onboardingList[index];
                return Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child:  CustomImageView(
                                    imagePath: data.playerimage,
                                      height: 470.v,
                                      width: 350.h,

                                      ),

                      ),
                      SizedBox(height: 50.v),
                              Text(
                                data.title!,
                                style: theme.textTheme.headlineMedium!.copyWith(
                                    color: appTheme.black900,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Montserrat-Medium'
                                )),
                      //discription
                      SizedBox(height: 16.v),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 31.h),
                                child: SizedBox(
                                  width:double.infinity,
                                  child: Text(
                                    data.subTitle!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      color: appTheme.black900,
                                      fontFamily: 'Montserrat-Medium',
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                              ),
                    ],
                  ),
                );
                //   Container(
                //   height: double.infinity,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       // image: DecorationImage(
                //       //     image: AssetImage(data.bgimage!),
                //       //     fit: BoxFit.cover)
                //   ),
                //   child: Padding(
                //     padding:  EdgeInsets.only(top: 57.v),
                //     child: Column(
                //       children: [
                //         CustomImageView(
                //           imagePath: data.playerimage,
                //             height: 482.v,
                //             width: 428.h,
                //             fit: BoxFit.fill,
                //             ),
                //         SizedBox(height: 61.v),
                //         Text(
                //           data.title!,
                //           style: theme.textTheme.headlineMedium!.copyWith(
                //               color: appTheme.black900,
                //               fontWeight: FontWeight.w700,
                //               fontFamily: 'Montserrat-Medium'
                //           ),
                //         ),
                //         SizedBox(height: 16.v),
                //         Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 31.h),
                //           child: SizedBox(
                //             width:double.infinity,
                //             child: Text(
                //               data.subTitle!,
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //               textAlign: TextAlign.center,
                //               style: theme.textTheme.bodyLarge!.copyWith(
                //                 color: appTheme.black900,
                //                 fontFamily: 'Montserrat-Medium',
                //                 height: 1.50,
                //               ),
                //             ),
                //           ),
                //         ),
                //
                //       ],
                //     ),
                //   ),
                // );
              },
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width * 0.44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    controller.onboardingList.length,
                      (index) => buildDot(index: index,page : controller.currentPage),
                ),
              ),
            ),
         controller.currentPage    <   controller.onboardingList.length - 1
                ? Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  ElevatedButton(
                    onPressed: () {
                      PrefUtils.setIsIntro(false);
                                  onTapTxtSkip();
                    },
                    child: Text(
                      "lbl_skip".tr,
                      style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15,
                        color: appTheme.black900,
                        fontFamily: 'Montserrat-Medium',
                    )),
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.only(top: 30,bottom: 30,right: 20,left: 10),

                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      controller.pageController.nextPage(
                                          duration: const Duration(
                                              milliseconds: 100),
                                          curve: Curves.bounceIn);
                    },
                    child: Text(
                      "lbl_next".tr,
                      style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15,
                        color: appTheme.black900,
                        fontFamily: 'Montserrat-Medium',
                        height: 1.50,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.only(top: 30,bottom: 30,left: 20,right: 10),

                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              bottomLeft: Radius.circular(18))),
                    ),
                  )
                ],
              ),
            )
                : Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.30,
              child: ElevatedButton(
                onPressed: () {
                  PrefUtils.setIsIntro(false);
                              Get.toNamed(
                                AppRoutes.loginScreen,
                              );
                },
                child: Text(
                  "Get Started",
                  style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15,
                    color: appTheme.black900,
                    fontFamily: 'Montserrat-Medium',

                  )),
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(27),
           
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            // Padding(
            //   padding:  EdgeInsets.only(bottom: 32.v),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: List.generate(
            //               controller.onboardingList.length, (index) {
            //             return AnimatedContainer(
            //               margin: EdgeInsets.only(left: 3.h, right: 3.h),
            //               duration:
            //               const Duration(milliseconds: 300),
            //               height: 8.v,
            //               width: index == controller.currentPage?24.h:8.v,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(24.h),
            //                   color:
            //                   (index == controller.currentPage)
            //                       ? appTheme.buttonColor
            //                       : appTheme.black40),
            //             );
            //           })),
            //       SizedBox(height: 48.v),
            //       CustomElevatedButton(
            //           text: controller.currentPage ==
            //               controller.onboardingList.length - 1
            //               ? "Get started"
            //               : "lbl_next".tr,
            //           margin: EdgeInsets.symmetric(horizontal: 20.h),
            //           onPressed: controller.currentPage ==
            //               controller.onboardingList.length - 1
            //               ? () {
            //             PrefUtils.setIsIntro(false);
            //             Get.toNamed(
            //               AppRoutes.loginScreen,
            //             );
            //           }
            //               : () {
            //             controller.pageController.nextPage(
            //                 duration: const Duration(
            //                     milliseconds: 100),
            //                 curve: Curves.bounceIn);
            //           },),
            //       SizedBox(height: 16.v),
            //       GestureDetector(
            //           onTap: () {
            //             PrefUtils.setIsIntro(false);
            //             onTapTxtSkip();
            //           },
            //           child: Text(controller.currentPage ==
            //               controller.onboardingList.length - 1
            //               ? "":"lbl_skip".tr,
            //               style: theme.textTheme.bodyLarge!.copyWith(
            //                   color: appTheme.black900,
            //                   fontFamily: 'Montserrat-Medium'
            //               ))),
            //     ],
            //   ),
            // )
          ],
            ),
          )),
    );
    
  }
  

  onTapTxtSkip() {
    Get.toNamed(
      AppRoutes.loginScreen,
    );
  }

  buildDot({required int index, required page}) {
    return AnimatedContainer(duration: Duration( seconds: 2),

      margin: EdgeInsets.only(right: 5),
      height: 8.v,
      width:   page == index ? 24.h:8.v,
      decoration: BoxDecoration(
        color: page == index ?    appTheme.buttonColor
                            : appTheme.black40,
        borderRadius: BorderRadius.circular(3),
      ),
    );

  }
  
}




