import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';
import 'package:sportsslot/core/utils/prefKeys.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/presentation/booking_details_one_screen/models/booking_details_one_model.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/presentation/detail_screen/models/detail_model.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';

/// A controller class for the BookingDetailsOneScreen.
/// This class manages the state of the BookingDetailsOneScreen, including the
/// current bookingDetailsOneModelObj

class BookingDetailsOneController extends GetxController {

  TextEditingController iclocationController = TextEditingController();

  //Rx<BookingDetailsOneModel> bookingDetailsOneModelObj = BookingDetailsOneModel().obs;

  String location = "";
  DateTime bookingDate = DateTime.now() ;
  String bookingTime = "";
  String price = "";
  String member = "";
  String bookingCode = "";
  String subGroundId = "";
  String subGroundName = "";
  String subGroundImage = "";

  RxBool loader = false.obs;



  Future<void> addBookingData(BookingModel bookingData, DocumentReference docRef) async {
    loader.value = true;
    try {

      await docRef.set(bookingData.toMap());

      String userId = PrefUtils.getString(PrefKey.userId);
      String userEmail = PrefUtils.getString(PrefKey.userEmail);


  await FirebaseFirestore.instance
      .collection(FirebaseKey.booking)
      .doc(userId)
      .set({"email": userEmail});

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(FirebaseKey.admin)
          .doc(FirebaseKey.groundDetails)
          .collection(FirebaseKey.groundDetails)
          .doc(bookingData.stadiumId)
          .get();

      if (documentSnapshot.exists) {

        Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
        GroundDetailModel groundData = GroundDetailModel.fromMap(map);
        List<SubGround> subGroundList = groundData.subGrounds ?? [];
        List<User> usersList = [];

        String selectedSubGroundId = bookingData.subGroundDetail.subGroundId;
        if (groundData.subGrounds != null) {
          SubGround selectedSubGround = groundData.subGrounds!.firstWhere(
                (element) => element.id == selectedSubGroundId,
            orElse: () => SubGround(users: [], name: '00000', duration: 00, price: 0000, id: '00000000000'),
          );
          usersList = selectedSubGround.users ?? [];
        }

        String bookingId = docRef.id;

        if (usersList.isNotEmpty) {
          if(usersList.any((user) => user.uid == userId))
          {
            User currentUser = usersList.firstWhere((user) => user.uid == userId, orElse: () => User(uid: userId, bookingId: []));
            currentUser.bookingId.add(bookingId);
          }
          else{
            usersList.add(User(uid: userId, bookingId: [bookingId]));
          }
        } else {
          usersList.add(User(uid: userId, bookingId: [bookingId]));
        }

        if (groundData.subGrounds != null) {
          for (int i = 0; i < groundData.subGrounds!.length; i++) {
            if (groundData.subGrounds![i].id == selectedSubGroundId) {
              groundData.subGrounds![i].users = usersList;
              break;
            }
          }
        }

        GroundDetailModel newGroundData = GroundDetailModel(
          categoryIdList: groundData.categoryIdList,
          categories: groundData.categories,
          features: groundData.features,
          mainGround: groundData.mainGround,
          subGrounds: subGroundList,
          timestamp: groundData.timestamp,
          review: groundData.review,
        );

        await updateStadiumData(newGroundData);
      }
      else{

      }
    } catch (e) {
      debugPrint(".....>>>>  Error: $e");
      loader.value = false;
    }
    loader.value = false;
  }

  Future<void> updateStadiumData(GroundDetailModel stadiumData) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Keys.admin)
        .doc(Keys.groundDetails)
        .collection(Keys.groundDetails)
        .where(Keys.timestamp, isEqualTo: stadiumData.timestamp)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
     try{
       await FirebaseFirestore.instance
           .collection(Keys.admin)
           .doc(Keys.groundDetails)
           .collection(Keys.groundDetails)
           .doc(docId)
           .update(stadiumData.toMap());
     } catch(e){

     }
    } else {
      errorToast("Stadium details not found");
    }
  }




 // Future addBookingData(Map<String, dynamic> bookingData, DocumentReference docRef) async{
 //   loader.value = true;
 //   try{
 //     await docRef.set(bookingData);
 //
 //     await FirebaseFirestore.instance
 //         .collection(FirebaseKey.booking)
 //         .doc(PrefUtils.getString(PrefKey.userId)).set({
 //       "email": PrefUtils.getString(PrefKey.userEmail)
 //     });
 //
 //     DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
 //         .collection(FirebaseKey.admin)
 //         .doc(FirebaseKey.groundDetails)
 //         .collection(FirebaseKey.groundDetails)
 //         .doc(bookingData["stadiumId"]).get();
 //
 //     if(documentSnapshot.data() != null) {
 //       Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
 //       GroundDetailModel groundData = GroundDetailModel.fromMap(map);
 //       List<User> usersList = groundData.subGrounds?.firstWhere((element) => element.id == selectedSubGroundId,).users ?? [];
 //
 //       List<String> bookingIdList = usersList.firstWhere((user) => user.uid == PrefUtils.getString(PrefKey.userId)).bookingId;
 //       print(bookingIdList);
 //
 //       if (usersList.isNotEmpty) {
 //         bookingIdList.add(docRef.id);
 //         List<SubGround> subGroundList = groundData.subGrounds ?? [];
 //         for (int i = 0; i < subGroundList.length; i++) {
 //           debugPrint("-=-=-=-: ${selectedSubGroundId}");
 //           if (subGroundList[i].id == selectedSubGroundId) {
 //             // for (int j = 0; j < (subGroundList[i].users?.length ?? 0); j++) {
 //             //   if ((subGroundList[i].users?[j].uid ?? "") ==
 //             //       PrefUtils.getString(PrefKey.userId)) {
 //             //     subGroundList[i].users?[j].bookingId = bookingIdList;
 //             //     break;
 //             //   }
 //             // }
 //
 //             if(usersList.any((user) => user.uid == PrefUtils.getString(PrefKey.userId)))
 //               {
 //
 //               }
 //             else{
 //
 //             }
 //
 //
 //             break;
 //           }
 //         }
 //         GroundDetailModel newGroundData = GroundDetailModel(
 //             categoryIdList: groundData.categoryIdList,
 //             categories: groundData.categories,
 //             features: groundData.features,
 //             mainGround: groundData.mainGround,
 //             subGrounds: subGroundList,
 //             timestamp: groundData.timestamp);
 //         await updateStadiumData(newGroundData);
 //       }
 //
 //       else {
 //         usersList.add(User(
 //             uid: PrefUtils.getString(PrefKey.userId), bookingId: [docRef.id]));
 //         List<SubGround> subGroundList = groundData.subGrounds ?? [];
 //         for (int i = 0; i < subGroundList.length; i++) {
 //           if (subGroundList[i].id == selectedSubGroundId) {
 //             subGroundList[i].users = usersList;
 //           }
 //         }
 //         GroundDetailModel newGroundData = GroundDetailModel(
 //             categoryIdList: groundData.categoryIdList,
 //             categories: groundData.categories,
 //             features: groundData.features,
 //             mainGround: groundData.mainGround,
 //             subGrounds: subGroundList,
 //             timestamp: groundData.timestamp);
 //         await updateStadiumData(newGroundData);
 //       }
 //     }
 //   }
 //   catch(e)
 //   {
 //     debugPrint("=-=-=-=-=-:  ${e}");
 //   }
 //   // await FirebaseFirestore.instance
 //   //     .collection(FirebaseKey.booking)
 //   //     .doc(PrefUtils.getString(PrefKey.userId))
 //   //     .collection(FirebaseKey.booking)
 //   //     .add(bookingData);
 //
 //
 //   loader.value = false;
 //  }


  @override
  void onClose() {
    super.onClose();
    iclocationController.dispose();
  }
}
