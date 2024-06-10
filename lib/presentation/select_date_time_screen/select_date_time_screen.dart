import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/presentation/detail_screen/models/ground_list_model.dart';
import 'package:sportsslot/presentation/home_page/controller/home_controller.dart';
import 'package:sportsslot/presentation/home_page/models/home_model.dart';
import 'package:sportsslot/presentation/popular_ground_screen/controller/popular_ground_controller.dart';
import 'package:sportsslot/widgets/custom_elevated_button.dart';
import 'package:sportsslot/widgets/custom_text_form_field.dart';
import 'package:intl/intl.dart';
import 'controller/select_date_time_controller.dart';
import 'models/select_date_time_model.dart';


class SelectDateTimeScreen extends StatefulWidget {
  const SelectDateTimeScreen({super.key});

  @override
  State<SelectDateTimeScreen> createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<SelectDateTimeScreen> {
 SelectDateTimeController selectDateTimeController = Get.put(SelectDateTimeController());
 PopularGroundController popularGroundController = Get.put(PopularGroundController());
 HomeController homeController = Get.put(HomeController(HomeModel().obs));

 List<DateTime?> _dates = [];
 List<String> day = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

 late GroundDetailListModel groundDetailListModel;
 late GroundListModel subGround;
 var cityName = "";
 List<QueryDocumentSnapshot> allBookingData = [];


 @override
 void initState() {

   groundDetailListModel = Get.arguments["data"];
   subGround = Get.arguments["subGround"];

   getLocationName();

   selectDateTimeController.timeData.value = [];


   for(int i=0; i<groundDetailListModel.getGroundList.length; i++){
     if(groundDetailListModel.getGroundList[i].title == subGround.title){
       selectDateTimeController.price =  groundDetailListModel.getGroundList[i].price;
       for(int j =0; j<(groundDetailListModel.getGroundList[i].timeShifts?.length??0); j++){
         selectDateTimeController.timeData.value.add(SelectDateTimeModel("${DateFormat.jm().format(groundDetailListModel.getGroundList[i].timeShifts?[j]["from"].toDate())} to ${DateFormat.jm().format(groundDetailListModel.getGroundList[i].timeShifts?[j]["to"].toDate())}"));
       }
     }
   }

   // if(selectDateTimeController.timeData.value.isNotEmpty){
   //   selectDateTimeController.bookingTime.value = selectDateTimeController.timeData.value[0].time??"";
   // }

   getBookingList();




   // TODO: implement initState
   super.initState();
 }

 getLocationName() async{

   cityName= await homeController.getLocationName(groundDetailListModel.latitude, groundDetailListModel.longitude);

   print(cityName);
 }


 getBookingList() async{

   selectDateTimeController.loader.value = true;

   var allUserData = await FirebaseFirestore.instance.collection(FirebaseKey.booking).get();


   if(allUserData.docs.isNotEmpty) {
     for (int j = 0; j < allUserData.docs.length; j++) {
       var userBookingData = await FirebaseFirestore.instance
           .collection(FirebaseKey.booking)
           .doc(allUserData.docs[j].id)
           .collection(FirebaseKey.booking)
           .get();

       allBookingData.addAll(userBookingData.docs);
     }
   }

   selectDateTimeController.loader.value = false;

   }




 @override
 Widget build(BuildContext context) {

  mediaQueryData = MediaQuery.of(context);
  return Scaffold(
      backgroundColor: appTheme.bgColor,

      body: SafeArea(
       child:  GestureDetector(
         onTap: (){
           FocusScope.of(context).unfocus();
         },
         child: Column(
             children:[

               getCommonAppBar("msg_select_date_time".tr),

               Expanded(child:
               Obx(() =>  !selectDateTimeController.loader.value
                   ? SingleChildScrollView(
                 child: Column(
                   children: [
                     SizedBox(height: 16.v),
                     CalendarDatePicker2(
                       config: CalendarDatePicker2Config(
                           weekdayLabelTextStyle: CustomTextStyles.titleMediumBold16,
                           weekdayLabels: day,
                           controlsTextStyle:
                           theme.textTheme.titleLarge!.copyWith(color: appTheme.black900),

                           customModePickerIcon: Padding(
                             padding:  EdgeInsets.only(left: 16.h),
                             child: CustomImageView(
                                 color: appTheme.black900,
                                 imagePath: ImageConstant.imgarrowDown,
                                 height: 24.adaptSize,
                                 width: 24.adaptSize),
                           ),
                           lastMonthIcon: CustomImageView(
                               color: appTheme.black900,
                               imagePath: ImageConstant.imgIcDown,
                               height: 24.adaptSize,
                               width: 24.adaptSize),
                           nextMonthIcon: CustomImageView(
                               color: appTheme.black900,
                               imagePath: ImageConstant.imgIcNext,
                               height: 24.adaptSize,
                               width: 24.adaptSize),
                           dayTextStyle:  CustomTextStyles.titleMediumGray60001,
                           selectedDayHighlightColor: appTheme.buttonColor,
                           selectedDayTextStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
                           firstDate: DateTime.now(),
                           selectedRangeHighlightColor: appTheme.buttonColor,
                           currentDate: DateTime.now()

                       ),
                       value: _dates,
                       onValueChanged: (value) {
                         _dates = value;
                         selectDateTimeController.selectedDate = _dates.first!;
                         print(selectDateTimeController.selectedDate);
                         selectDateTimeController.timeData.refresh();
                       },
                     ),
                     SizedBox(height: 19.v),

                     Align(
                         alignment: Alignment.centerRight,
                         child: Padding(
                           padding: EdgeInsets.only(left: 20.h, right: 20.h),
                           child:   Text("₹ ${selectDateTimeController.price}/hour",
                               style: theme.textTheme.titleLarge!.copyWith(
                                 color: appTheme.buttonColor,
                               )),
                           // child:    Row(
                           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           //   children: [
                           //     Text("lbl_price".tr,
                           //         style: theme.textTheme.titleLarge!.copyWith(
                           //           color: appTheme.black900,
                           //         )),
                           //     Text("₹ ${selectDateTimeController.price}",
                           //         style: theme.textTheme.titleLarge!.copyWith(
                           //           color: appTheme.buttonColor,
                           //         )),
                           //   ],
                           // )
                         )
                     ),
                     SizedBox(height: 22.v),
                     Align(
                         alignment: Alignment.centerLeft,
                         child: Padding(
                           padding: EdgeInsets.only(left: 20.h, right: 20.h),
                           child:     Text("lbl_member".tr,
                               style: theme.textTheme.titleLarge!.copyWith(
                                 color: appTheme.black900,
                               )),
                         )
                     ),
                     SizedBox(height: 19.v),
                     Padding(
                         padding: EdgeInsets.symmetric(horizontal: 20.h),
                         child: CustomTextFormField(
                           controller: selectDateTimeController.memberController,
                           hintText: "Enter number of member",
                           textInputType: TextInputType.number,
                         )
                       // SizedBox(
                       //   width: double.maxFinite,
                       //   child: TextFormField(
                       //     focusNode: controller.focusNode,
                       //     controller: controller.memberController,
                       //     style:  theme.textTheme.bodyLarge!.copyWith(color:appTheme.black900),
                       //     keyboardType: TextInputType.number,
                       //     decoration: InputDecoration(
                       //       hintText: "Enter number of member",
                       //       contentPadding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 18.v),
                       //       fillColor: appTheme.textfieldFillColor,
                       //       filled: true,
                       //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.h), borderSide: BorderSide.none),
                       //     ),
                       //   ),
                       // ),

                     ),

                     SizedBox(height: 19.v),
                     Align(
                         alignment: Alignment.centerLeft,
                         child: Padding(
                             padding: EdgeInsets.only(left: 20.h, right: 20.h),
                             child: Text("lbl_select_time".tr,
                                 style: theme.textTheme.titleLarge!.copyWith(
                                   color: appTheme.black900,
                                 ))
                         )
                     ),
                     SizedBox(height: 19.v),

                     Obx(() =>  GridView.builder(
                         padding: EdgeInsets.symmetric(horizontal: 20.h),
                         primary: false,
                         shrinkWrap: true,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           mainAxisExtent: 56.v,
                           crossAxisCount: 2,
                           crossAxisSpacing: 16.h,
                           mainAxisSpacing: 16.v,),
                         itemCount: selectDateTimeController.timeData.value.length,
                         itemBuilder: (context, index) {

                           SelectDateTimeModel data = selectDateTimeController.timeData.value[index];


                           selectDateTimeController.isAddBooking.value = true;

                           if(selectDateTimeController.selectedDate != null){

                             for(int i = 0 ; i<allBookingData.length; i++){

                               var dataF = allBookingData[i];



                               String bookingSelectDate = "${DateFormat('yyyy-MM-dd').format(dataF["selectDate"].toDate())}";

                               String? allStart = dataF["selectTime"].split(" to ")[0].toString();

                               String? hS = allStart.split(":").first;
                               String? mS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                               String? pS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();


                               String? allEnd = dataF["selectTime"].split(" to ")[1].toString();

                               String? hE = allEnd.split(":").first;
                               String? mE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                               String? pE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

                               DateTime bookingStartTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${bookingSelectDate} $hS:$mS $pS");
                               DateTime bookingEndTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${bookingSelectDate} $hE:$mE $pE");

                               /// =========================


                               String selectDate = "${DateFormat('yyyy-MM-dd').format(selectDateTimeController.selectedDate!)}";

                               String? timeStart = data.time?.split(" to ")[0].toString();
                               String? hS2 = timeStart?.split(":").first;
                               String? mS2 = timeStart?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                               String? pS2 = timeStart?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();


                               String? timeEnd = data.time?.split(" to ")[1].toString();
                               String? hE2 = timeEnd?.split(":").first;
                               String? mE2 = timeEnd?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                               String? pE2 = timeEnd?.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

                               DateTime selectStartTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hS2:$mS2 $pS2");
                               DateTime selectEndTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hE2:$mE2 $pE2");


                               if(selectStartTime.isBefore(DateTime.now())){
                                 selectDateTimeController.isAddBooking.value = false;
                               } else{
                                 if(dataF["isCancelBooking"] == false){
                                   if(dataF["stadiumId"] == groundDetailListModel.stadiumId
                                       && dataF["subGroundDetail"]["subGroundId"] == subGround.subGroundId
                                       && bookingSelectDate == selectDate
                                       && dataF["selectTime"] != data.time
                                   ){
                                     if ((selectStartTime.isBefore(bookingEndTime) && selectEndTime.isAfter(bookingStartTime)) ||
                                         (selectStartTime.isAtSameMomentAs(bookingStartTime) || selectEndTime.isAtSameMomentAs(bookingEndTime))) {

                                       selectDateTimeController.isAddBooking.value = false;

                                     }
                                   } else if(
                                   dataF["stadiumId"] == groundDetailListModel.stadiumId
                                       && dataF["subGroundDetail"]["subGroundId"] == subGround.subGroundId
                                       && bookingSelectDate == selectDate
                                       && dataF["selectTime"] == data.time
                                   ){
                                     selectDateTimeController.isAddBooking.value = false;

                                   }
                                 }
                               }



                             }
                           }


                           return selectDateTimeController.isAddBooking.value
                               ? GestureDetector(
                             onTap: (){

                                 selectDateTimeController.currentTime = index.obs;
                                 selectDateTimeController.bookingTime.value = data.time!;


                               //selectDateTimeController.update();

                               setState(() {});
                             },
                             child: Container(
                               padding: EdgeInsets.symmetric(horizontal: 10.h),
                               decoration: BoxDecoration(
                                   color: selectDateTimeController.currentTime?.value == index?appTheme.secondarybgcolor:appTheme.textfieldFillColor,
                                   borderRadius: BorderRadius.circular(20.h),
                                   border: Border.all(
                                       color:  selectDateTimeController.currentTime?.value == index?appTheme.buttonColor:Colors.transparent,
                                       width: 1.h)),
                               child: Center(
                                 child: Text(data.time!,
                                     style: theme.textTheme.bodyLarge!.copyWith(
                                       color: appTheme.black900,
                                     )),
                               ),),
                           )
                               : Container(
                             padding: EdgeInsets.symmetric(horizontal: 10.h),
                             decoration: BoxDecoration(
                               color: PrefUtils().getThemeData() == "primary" ? appTheme.gray300 : Color(0XFF6e6e6e),
                               borderRadius: BorderRadius.circular(20.h),
                             ),
                             child: Center(
                               child: Text(data.time!,
                                   style: theme.textTheme.bodyLarge!.copyWith(
                                     color: appTheme.black900,
                                   )),
                             ),);
                         }),),
                     SizedBox(height: 18.v),
                   ],
                 ),
               )
                   : Center(child: CircularProgressIndicator(),)
               ),
               ),
             ]

               ),
       )


      ),
    bottomNavigationBar:  Obx(() => !selectDateTimeController.loader.value
        ? Container(
      width: double.infinity,
      color: appTheme.bgColor,
      child: Padding(
        padding:  EdgeInsets.only(left: 16.h,right: 16.h,top: 16.v,bottom: 32.v),
        child: CustomElevatedButton(
            text: "lbl_continue".tr,
            onPressed: () async{

              String bookingCode = selectDateTimeController.generateRandomCode(6);

              FocusScope.of(context).unfocus();

              if(selectDateTimeController.selectedDate == null) {
                errorToast("Please select booking date");
              } else if (selectDateTimeController.bookingTime.value.isEmpty){
                errorToast("Please select booking time");
              } else if (selectDateTimeController.memberController.text.isEmpty){
                errorToast("Please add member");
              } else {



                String? allStart = selectDateTimeController.bookingTime.value.split(" to ")[0].toString();
                String? hS = allStart.split(":").first;
                String? mS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                String? pS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

                String? allEnd = selectDateTimeController.bookingTime.value.split(" to ")[1].toString();
                String? hE = allEnd.split(":").first;
                String? mE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
                String? pE = allEnd.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

                TimeOfDay startTime = stringToTimeOfDay("$hS:$mS $pS");
                TimeOfDay endTime = stringToTimeOfDay("$hE:$mE $pE");

                Duration difference = calculateTimeDifference(startTime, endTime);

                var parMinute = selectDateTimeController.price/60;

                double price = parMinute * difference.inMinutes;


                await Get.toNamed(
                    AppRoutes.bookingDetailsOneScreen,
                    arguments: {
                      "location" : cityName,
                      "booking_date" : selectDateTimeController.selectedDate,
                      "booking_time" : selectDateTimeController.bookingTime.value,
                      "price": "₹ ${price.toStringAsFixed(1)}",
                      "member": selectDateTimeController.memberController.text.trim(),
                      "bookingCode": bookingCode,
                      "model": groundDetailListModel,
                      "subGroundId": subGround.subGroundId,
                      "subGroundName" : subGround.title,
                      "subGroundImage": subGround.image,
                    }
                );
              }
            }),
      ),
    )
        : SizedBox(),)

  );
 }

 TimeOfDay stringToTimeOfDay(String timeString) {
   // Split the string to separate hours and minutes
   List<String> timeParts = timeString.split(':');
   int hours = int.parse(timeParts[0]);

   // Check if it's PM, adjust hours accordingly
   if (timeString.contains("PM") && hours != 12) {
     hours += 12;
   }

   // Extract minutes
   String minutesPart = timeParts[1].replaceAll(RegExp('[^0-9]'), '');
   int minutes = int.parse(minutesPart);

   return TimeOfDay(hour: hours, minute: minutes);
 }

 Duration calculateTimeDifference(TimeOfDay startTime, TimeOfDay endTime) {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

   // Handle case where end time is before start time (e.g., next day)
   if (endMinutes < startMinutes) {
     // Add a day to end time
     endMinutes += 24 * 60;
   }

   return Duration(minutes: endMinutes - startMinutes);
 }

 /// Navigates to the bookingDetailsOneScreen when the action is triggered.
 onTapContinue() {
  Get.toNamed(
   AppRoutes.bookingDetailsOneScreen,
    arguments: {
     "booking_date"
    }
  );
 }
}




