import 'dart:html' as html;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/Common/common_methods.dart';
import 'package:sportsslot/web/Common/common_primary_button.dart';
import 'package:sportsslot/web/Screen/ground_detail/all_ground_detail/all_ground_detail_controller.dart';
import 'package:sportsslot/web/helper/theme/theme_controller.dart';
import 'package:sportsslot/web/model/booking_model.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:intl/intl.dart';

class bookingHistoryController extends GetxController {
  RxBool loader = false.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString selectedStartDate = "".obs;
  RxString selectedEndDate = "".obs;
  RxList<GroundDetailModel> stadiumList = <GroundDetailModel>[].obs;
  RxList<bool> isShowSubGround = <bool>[].obs;
  RxList<SubGround> allSubGroundList = <SubGround>[].obs;
  RxList<List<int>> totalUpComingBookSubGround = <List<int>>[].obs;
  RxList<String> allUserIdList = <String>[].obs;
  RxList<String> bookingIdList = <String>[].obs;
  RxList<Map<String, dynamic>> allBookingRecord = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filterBookingList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> BookingRecordForFuture = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    // init();
    super.onInit();
  }

  Future<void> init() async {
    loader.value = true;
    stadiumList.value = await getGroundDetailsData();
    isShowSubGround.value = List.generate(stadiumList.value.length, (index) => false);
    isShowSubGround.refresh();
    loader.value = false;
  }

  Future<List<GroundDetailModel>> getGroundDetailsData() async {
    List<GroundDetailModel> groundDetails = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Keys.admin)
          .doc(Keys.groundDetails)
          .collection(Keys.groundDetails)
          .orderBy("timestamp", descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          GroundDetailModel groundDetailModel = GroundDetailModel.fromMap(data);
          groundDetails.add(groundDetailModel);
        }
      }
    } catch (e) {
      print("Error fetching sport icons: $e");
    }
    return groundDetails;
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked =
        await showCommonDatePicker(context: context, initDate: startDate.value, );
    if (picked != null && picked != startDate.value) {
      if (selectedEndDate.value.isNotEmpty) {
        if (picked.isBefore(
                DateFormat("dd/MM/yyyy").parse(selectedEndDate.value)) ||
            DateFormat("dd/MM/yyyy")
                    .parse(DateFormat("dd/MM/yyyy").format(picked)) ==
                (DateFormat("dd/MM/yyyy").parse(selectedEndDate.value))) {
          startDate.value = picked;
          selectedStartDate.value = DateFormat("dd/MM/yyyy").format(picked);
          dateWiseFilter();
        } else {
          errorToast("invalidDateRange".tr);
        }
      } else {
        startDate.value = picked;
        selectedStartDate.value = DateFormat("dd/MM/yyyy").format(picked);
        dateWiseFilter();
      }
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? picked =
        await showCommonDatePicker(context: context, initDate: endDate.value);
    if (picked != null && picked != endDate.value) {
      if (selectedStartDate.value.isNotEmpty) {
        if (picked.isAfter(
                DateFormat("dd/MM/yyyy").parse(selectedStartDate.value)) ||
            DateFormat("dd/MM/yyyy")
                    .parse(DateFormat("dd/MM/yyyy").format(picked)) ==
                (DateFormat("dd/MM/yyyy").parse(selectedStartDate.value))) {
          endDate.value = picked;
          selectedEndDate.value = DateFormat("dd/MM/yyyy").format(picked);
          dateWiseFilter();
        } else {
          errorToast("invalidDateRange".tr);
        }
      } else {
        endDate.value = picked;
        selectedEndDate.value = DateFormat("dd/MM/yyyy").format(picked);
        dateWiseFilter();
      }
    }
  }

  //   await showDatePicker(
  //     context: context,
  //     initialDate: endDate?.value ?? DateTime.now(),
  //     firstDate: startDate?.value ?? DateTime(2000),
  //     lastDate: DateTime.now(),
  //
  //   );
  //   if (picked != null && picked != endDate) {
  //      endDate?.value = picked;
  //   }
  // }

  Future<void> bookingViewDialog({
    required BuildContext context,
    // required double width,
    // required double height,
    //   required SizingInformation sizingInformation
    required List<User> users,
    required List<String> bookingIdList,
  }) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        final double width = MediaQuery.of(context).size.width;
        final double height = MediaQuery.of(context).size.height;
        double titleFontSize = width * 0.0097;
        double dataFontSize = width * 0.009;
        if (width > 1700) {
          titleFontSize = width * 0.0097;
          dataFontSize = width * 0.009;
        } else if (width > 1500 && width < 1700) {
          titleFontSize = width * 0.01075;
          dataFontSize = width * 0.0097;
        } else if (width > 1200 && width < 1500) {
          titleFontSize = width * 0.0112;
          dataFontSize = width * 0.0104;
        } else if (width < 1200) {
          titleFontSize = width * 0.012;
          dataFontSize = width * 0.011;
        }

        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
                ThemeController themeController = Get.find<ThemeController>();
            return AlertDialog(
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: width * 0.02)
                  .copyWith(top: width * 0.012),
              insetPadding: EdgeInsets.only(
                  right: width * 0.02,
                  top: height * 0.1,
                  bottom: height * 0.06),
              content: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: Get.width, maxHeight: Get.height),
                          margin: EdgeInsets.only(
                              left: Get.width * 0.02, right: Get.width * 0.005),
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.008,
                              vertical: Get.height * 0.0095),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: themeController.c.value,//Colors.white,
                          ),
                          alignment: Alignment.center,
                          height: Get.height,
                          width: Get.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "totalBooking".tr,
                                    style: mediumFontStyle(
                                        size: Get.width * 0.0116),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 3, bottom: 3, top: 2),
                                      color: Colors.transparent,
                                      child: Icon(Icons.close,
                                          color: appTheme.dotted, size: 27),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Divider(
                                  thickness: 1,

                                  endIndent: 5,
                                  indent: 5,
                                  height: 25),
                              Align(
                                alignment: Alignment.centerRight,
                                child: CommonPrimaryButton(
                                    text: "   ${"exportLbl".tr}   ",
                                    onTap: () async {
                                      createCoachExel(
                                          filterBookingList.value, "bookingHistory");
                                    }),
                              ),
                              SizedBox(height: height * 0.02),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: appTheme.themeColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      flex: 14,
                                      child: Text(
                                        "lbl_name".tr,
                                        textAlign: TextAlign.center,
                                        style: mediumFontStyle(
                                          size: titleFontSize,
                                          color: appTheme.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 20,
                                      child: Text(
                                        "email".tr,
                                        textAlign: TextAlign.center,
                                        style: mediumFontStyle(
                                          size: titleFontSize,
                                          color: appTheme.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Text(
                                        "date".tr,
                                        textAlign: TextAlign.center,
                                        style: mediumFontStyle(
                                          size: titleFontSize,
                                          color: appTheme.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 17,
                                      child: Text(
                                        "lbl_timing".tr,
                                        textAlign: TextAlign.center,
                                        style: mediumFontStyle(
                                          size: titleFontSize,
                                          color: appTheme.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Text(
                                        "mobileNumber".tr,
                                        textAlign: TextAlign.center,
                                        style: mediumFontStyle(
                                          size: titleFontSize,
                                          color: appTheme.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Text(
                                        "member".tr,
                                        textAlign: TextAlign.center,
                                        style: mediumFontStyle(
                                          size: titleFontSize,
                                          color: appTheme.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: themeController.c.value,//appTheme.white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Obx(
                                    () => ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: filterBookingList.value.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                          height: 24,
                                          thickness: 1,
                                          color: appTheme.colorCACACA,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> data =
                                            filterBookingList.value[index];
                                        return Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8)
                                                  .copyWith(
                                                      top: index == 0 ? 18 : 8),
                                          color: Colors.transparent,
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              final double rowWidth =
                                                  constraints.maxWidth;
                                              return Flex(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Expanded(
                                                    flex: 14,
                                                    child: Text(
                                                      data["userDetail"]["userName"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: mediumFontStyle(
                                                        size: dataFontSize,
                                                        color: themeController.d.value,//appTheme.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  Expanded(
                                                    flex: 20,
                                                    child: Text(
                                                      data["userDetail"]["userEmail"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: mediumFontStyle(
                                                        size: dataFontSize,
                                                        color: themeController.d.value,//appTheme.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      DateFormat("dd/MM/yyyy").format(data["selectDate"].toDate()),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: mediumFontStyle(
                                                        size: dataFontSize,
                                                        color: themeController.d.value,//appTheme.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 17,
                                                    child: Text(
                                                      data["selectTime"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: mediumFontStyle(
                                                        size: dataFontSize,
                                                        color: themeController.d.value,//appTheme.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 10,
                                                    child: Text(
                                                      data["userDetail"]["userMobile"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: mediumFontStyle(
                                                        size: dataFontSize,
                                                        color: themeController.d.value,//appTheme.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 9,
                                                    child: Text(
                                                      data["member"],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: mediumFontStyle(
                                                        size: dataFontSize,
                                                        color: themeController.d.value,//appTheme.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void createCoachExel(List<Map<String, dynamic>> data, String fileName) async {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
    sheet.setColumnWidth(0, 20);
    sheet.setColumnWidth(1, 20);
    sheet.setColumnWidth(2, 20);
    sheet.setColumnWidth(3, 20);
    sheet.setColumnWidth(4, 20);
    sheet.setColumnWidth(5, 20);
    sheet.appendRow([
      const TextCellValue("Name"),
      const TextCellValue("Email"),
      const TextCellValue("Date"),
      const TextCellValue("Timing"),
      const TextCellValue("Mobile Number"),
      const TextCellValue("Member"),
    ]);

    data.forEach((data) {
      sheet.appendRow([
        TextCellValue(data["userDetail"]["userName"]),
        TextCellValue(data["userDetail"]["userEmail"]),
        TextCellValue(DateFormat("dd/MM/yyyy").format(data["selectDate"].toDate())),
        TextCellValue(data["selectTime"]),
        TextCellValue(data["userDetail"]["userMobile"]),
        TextCellValue(data["member"]),
      ]);
    });

    // Save file
    // var bytes = excel.encode();
    // final directory = await getApplicationDocumentsDirectory();
    // final file = File('${directory.path}/$fileName.xlsx');
    // await file.writeAsBytes(bytes);

    // Save file
    var bytes = excel.encode();
    final blob = html.Blob([bytes],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '$fileName.xlsx')
      ..click();

    html.Url.revokeObjectUrl(url);

    // print('Excel file saved to: ${file.path}');
  }



  RxList<GroundDetailModel> allStadiumDetails = <GroundDetailModel>[].obs;

  Future<void> getStadiumData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Keys.admin)
        .doc(Keys.groundDetails)
        .collection(Keys.groundDetails)
        .orderBy("timestamp", descending: true)
        .get();
    for (QueryDocumentSnapshot data in snapshot.docs) {
      Map<String, dynamic> stadiumData = data.data() as Map<String, dynamic>;
      allStadiumDetails.value.add(GroundDetailModel.fromMap(stadiumData));
      allStadiumDetails.refresh();
      isShowSubGround.value =
          List.generate(allStadiumDetails.value.length, (index) => false);
      isShowSubGround.refresh();
    }
    getAllSubGroundAndUsers();
    // getAllBookingId();
    allBookingRecord.value =
        await fetchData(bookingIdList: bookingIdList.value);
    filterBookingList.value.assignAll(allBookingRecord.value);
    BookingRecordForFuture.value.assignAll(allBookingRecord.value);
    allBookingRecord.refresh();
    filterBookingList.refresh();
    BookingRecordForFuture.refresh();
    countTotalBooking();
  }

  void getAllSubGroundAndUsers() {
    for (GroundDetailModel stadium in allStadiumDetails.value) {
      for (SubGround subGround in stadium.subGrounds ?? []) {
        allSubGroundList.value.add(subGround);
        allUserIdList.value.addAll(
            (subGround.users ?? []).map((element) => element.uid).toList());
        for (User user in subGround.users ?? []) {
          bookingIdList.value.addAll(user.bookingId);
        }
        allUserIdList.value = allUserIdList.value.toSet().toList();
        bookingIdList.value = bookingIdList.value.toSet().toList();
        allSubGroundList.refresh();
        allUserIdList.refresh();
        bookingIdList.refresh();
      }
    }
  }

  // List<String> getAllBookingId() {
  //   bookingIdList.clear();
  //   for (User user in allUserIdList.value) {
  //     bookingIdList.addAll(user.bookingId);
  //   }
  //   debugPrint("-=-=-=-=-=-:  ${bookingIdList}");
  //   return bookingIdList;
  // }

  Future<List<Map<String, dynamic>>> fetchData(
      {List<User>? users, List<String>? bookingIdList}) async {
    try {
      loader.value = true;

      List<List<String>> chunkedUserIds = [];
      List<String> userIds = users != null
          ? users.map((element) => element.uid).toList()
          : allUserIdList.value;

      // Splitting the list of user IDs into chunks of 30 or fewer elements
      for (int i = 0; i < userIds.length; i += 30) {
        chunkedUserIds.add(userIds.sublist(
            i, i + 30 < userIds.length ? i + 30 : userIds.length));
      }

      List<DocumentSnapshot> allUserSnapshots = [];
      // Fetching documents for each chunk of user IDs
      for (List<String> chunk in chunkedUserIds) {
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('booking')
            .where(FieldPath.documentId, whereIn: chunk)
            .get();
        allUserSnapshots.addAll(userSnapshot.docs);
      }

      List<String> userDocIds = allUserSnapshots.map((doc) => doc.id).toList();


      // Function to batch booking IDs
      List<List<String>> batchBookingIds(List<String> bookingIdList) {
        List<List<String>> batches = [];
        for (int i = 0; i < bookingIdList.length; i += 30) {
          batches.add(bookingIdList.sublist(i, i + 30 < bookingIdList.length ? i + 30 : bookingIdList.length));
        }
        return batches;
      }

      List<List<String>> batchesOfBookingIds = batchBookingIds(bookingIdList ??[]);

// Fetching subcollection snapshots for each batch of booking IDs
      List<List<Map<String, dynamic>>> allDocs = [];
      await Future.forEach(batchesOfBookingIds, (batch) async {
        List<QuerySnapshot> subCollectionSnapshots = await Future.wait(userDocIds.map((id) =>
            FirebaseFirestore.instance
                .collection('booking')
                .doc(id)
                .collection('booking')
                .where(FieldPath.documentId, whereIn: batch)
                .get()));



        List<Map<String, dynamic>> docs = [];
        subCollectionSnapshots.forEach((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            docs.add(doc.data() as Map<String, dynamic>);
          });
        });
        allDocs.add(docs);
      });
      List<Map<String, dynamic>> flattenedDocs = allDocs.expand((docs) => docs).toList();

      loader.value = false;
      return flattenedDocs;
    } catch (e) {
      loader.value = false;
      print("Error: $e");
      return [];
    }
  }

  // void getTotalUpcommingBooking() {
  //   int totalBooking = 0;
  //   List<String> stadiumBookingIdList = [];
  //   totalUpComingBookSubGround.clear();
  //   for (GroundDetailModel stadium in stadiumList.value) {
  //     {
  //       List<int> totalCount = [];
  //       for (SubGround subGround in stadium.subGrounds ?? []) {
  //         for (User user in subGround.users ?? []) {
  //           // totalBooking = totalBooking + user.bookingId.length;
  //           totalCount.add(user.bookingId.length);
  //           stadiumBookingIdList.addAll(user.bookingId);
  //         }
  //       }
  //       totalUpComingBookSubGround.value.add(totalCount);
  //     }
  //   }
  //
  //   stadiumBookingIdList = stadiumBookingIdList.toSet().toList();
  // }

  List<int> getTotalUpcommingBookingBySubGround(List<SubGround>? subGrounds) {
    if ((subGrounds ?? []).isNotEmpty) {
      int totalUpcomingBooking = 0;
      int previousBooking = 0;

      List<String> bookingIdList = [];
      for (SubGround subGround in subGrounds!) {
        for (User user in subGround.users ?? []) {
          // totalBooking = totalBooking + user.bookingId.length;
          bookingIdList.addAll(user.bookingId);
        }
      }
      bookingIdList = bookingIdList.toSet().toList();
      for (int i = 0; i < allBookingRecord.value.length; i++) {
        BookingModel data = BookingModel.fromMap(allBookingRecord.value[i]);
        if (bookingIdList.contains(data.id)) {
          if (convertTimestampToDate(date: allBookingRecord.value[i]["selectDate"].toDate(),time: allBookingRecord.value[i]["selectTime"]).isAfter(DateTime.now())) {
            totalUpcomingBooking++;
          } else {
            previousBooking++;
          }
        }
      }
      return [totalUpcomingBooking,previousBooking];
    } else {
      return [0,0];
    }
  }



  // int getTotalBook(List<SubGround>? subGrounds){
  //   if ((subGrounds ?? []).isNotEmpty) {
  //     int totalBooking = 0;
  //     for (SubGround subGround in subGrounds!) {
  //       for (User user in subGround.users ?? []) {
  //         totalBooking = totalBooking + user.bookingId.length;
  //       }
  //     }
  //   return totalBooking;
  //   }
  //   else{
  //     return 0;
  //   }
  // }



  List<String> getTotalUpcomingBookingAndId(SubGround subGround){

      List<String> bookingIdList = [];
      List<String> groundBookingIds = [];

        for (User user in subGround.users ?? []) {
          groundBookingIds.addAll(user.bookingId);
        }

      groundBookingIds = groundBookingIds.toSet().toList();
      for (int i = 0; i < allBookingRecord.value.length; i++) {
        if (groundBookingIds.contains(allBookingRecord.value[i]["id"])) {
          if (convertTimestampToDate(date: allBookingRecord.value[i]["selectDate"].toDate(),time: allBookingRecord.value[i]["selectTime"]).isAfter(DateTime.now())) {
            bookingIdList.add(allBookingRecord.value[i]["id"]);
          } else {}
        }
      }
      return bookingIdList;
  }


  List<String> getTotalPreviousBookingAndId(SubGround subGround){

    List<String> bookingIdList = [];
    List<String> groundBookingIds = [];

    for (User user in subGround.users ?? []) {
      groundBookingIds.addAll(user.bookingId);
    }

    groundBookingIds = groundBookingIds.toSet().toList();
    for (int i = 0; i < allBookingRecord.value.length; i++) {
      if (groundBookingIds.contains(allBookingRecord.value[i]["id"])) {
        if (convertTimestampToDate(date: allBookingRecord.value[i]["selectDate"].toDate(),time: allBookingRecord.value[i]["selectTime"]).isBefore(DateTime.now())) {
          bookingIdList.add(allBookingRecord.value[i]["id"]);
        }
      }
    }
    return bookingIdList;
  }


  DateTime convertTimestampToDate({required DateTime date,required String time}) {
    String selectDate = "${DateFormat('yyyy-MM-dd').format(date)}";
    String? allStart = time.split(" to ")[0].toString();
    String? hS = allStart.split(":").first;
    String? mS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").first.trim();
    String? pS = allStart.replaceAll("AM", " AM").replaceAll("PM", " PM").split(":").last.split(" ").last.trim();

    DateTime startTime = DateFormat('yyyy-MM-dd hh:mm a').parse("${selectDate} $hS:$mS $pS");
    return startTime;
  }


  Future<void> dateWiseFilter() async{
    if(selectedStartDate.value.isNotEmpty && selectedEndDate.value.isNotEmpty)
      {
        List<Map<String,dynamic>> newFilterRecord = [];
        for(int i=0; i<BookingRecordForFuture.value.length; i++)
          {
            BookingModel data = BookingModel.fromMap(BookingRecordForFuture.value[i]);
            if(data.selectDate.isAfter(startDate.value) && data.selectDate.isBefore(endDate.value))
              {
                newFilterRecord.add(BookingRecordForFuture.value[i]);
              }
          }
        allBookingRecord.value.clear();
        allBookingRecord.value.assignAll(newFilterRecord);
        allBookingRecord.refresh();
        loader.value = true;
        await Future.delayed(Duration(milliseconds: 500),(){
          countTotalBooking();
        });

        loader.value = false;
        // allBookingRecord.value =   await fetchData(bookingIdList: allBookingRecord.value.map((e) => e["id"].toString()).toList());
        // getTotalUpcommingBookingBySubGround();
      }
  }



  RxInt totalUpcomming = 0.obs;
  RxInt totalBooking = 0.obs;
  void countTotalBooking() {
    List<String> bookingIdList = [];
    int totalUpcomingBooking = 0;
    int totalBook = 0;
    for (SubGround subGround in allSubGroundList.value) {
      for (User user in subGround.users ?? []) {
        // totalBooking = totalBooking + user.bookingId.length;
        bookingIdList.addAll(user.bookingId);
      }
    }
    bookingIdList = bookingIdList.toSet().toList();
    for (int i = 0; i < allBookingRecord.value.length; i++) {
      BookingModel data = BookingModel.fromMap(allBookingRecord.value[i]);
      if (bookingIdList.contains(data.id)) {
        if(selectedStartDate.value.isNotEmpty && selectedEndDate.value.isNotEmpty){
          if(data.selectDate.isAfter(startDate.value) && data.selectDate.isBefore(endDate.value))
            {
              if (convertTimestampToDate(date: allBookingRecord.value[i]["selectDate"].toDate(),time: allBookingRecord.value[i]["selectTime"]).isAfter(DateTime.now())) {
                totalUpcomingBooking++;
              }
            }
        }
        else{
          if (convertTimestampToDate(date: allBookingRecord.value[i]["selectDate"].toDate(),time: allBookingRecord.value[i]["selectTime"]).isAfter(DateTime.now())) {
            totalUpcomingBooking++;
          }
        }
        totalBook++;
      }
    }
    totalUpcomming.value = totalUpcomingBooking;
    totalBooking.value = totalBook;
    // return [totalUpcomingBooking,bookingIdList.length];
  }


}
