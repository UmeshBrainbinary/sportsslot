import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sportsslot/core/app_export.dart';
import 'package:sportsslot/core/utils/toast_message.dart';
import 'package:sportsslot/web/Common/common_methods.dart';
import 'package:sportsslot/web/Screen/ground_detail/all_ground_detail/all_ground_detail_controller.dart';
import 'package:sportsslot/web/Screen/logo_icon/logo_icon_controller.dart';
import 'package:sportsslot/web/model/ground_detail_model.dart';
import 'package:sportsslot/web/utils/firebase_keys.dart';
import 'package:sportsslot/web/utils/style_res.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class AddGroundDetailController extends GetxController {
  // RxString singleGroundImageUrl = "".obs;
  RxString featuresIcon = "".obs;
  RxBool loader = false.obs;
  List<String> selectedCategory = [];
  List<ValueItem> selectedCategoryValueItem = [];
  RxList<String> mainGroundImageList = <String>[].obs;
  RxList<String> subGroundImageList = <String>[].obs;
  RxList<Features> featuresList = <Features>[].obs;
  RxList<SubGround> subGroundsList = <SubGround>[].obs;
  TextEditingController groundNameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController taglineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController featureController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController subGroundName = TextEditingController();
  TextEditingController durationController = TextEditingController();

  RxList<TextEditingController> fromTimePickerControllerList =
      <TextEditingController>[TextEditingController()].obs;
  RxList<TextEditingController> toTimePickerControllerList =
      <TextEditingController>[TextEditingController()].obs;
  // TextEditingController fromTimePickerController = TextEditingController();
  // TextEditingController toTimePickerController = TextEditingController();
  late LogoIconController logoIconController;
  RxBool isShiftUpdating = false.obs;
  // RxList<String> selectedSubGImg = <String>[].obs;
  int selectedSubGroundIndex = 0;
  List images = [];

  String? formattedTime;
  RxList<ValueItem> category = <ValueItem>[].obs;
  DateTime? timeStampForUpdate;
  List<String> mainGroundImgListForUpdate = [];
  List<List<String>> subGroundImgListForUpdate = [];
  late AllGroundDetailController allGroundDetailController;

  @override
  void onInit() {
    init();
    allGroundDetailController = Get.find<AllGroundDetailController>();
    super.onInit();
  }

  Future<void> init()async{
    if(Get.isRegistered<LogoIconController>())
    {
      logoIconController= Get.find<LogoIconController>();
    }
    else{
      logoIconController= Get.put(LogoIconController());
    }
    logoIconController.sportIconList.isEmpty ? await logoIconController.init(): null;
    category.clear();
    category.value = logoIconController.sportIconList.map((sportIcon) =>
        ValueItem(label: sportIcon.name, value: "0")).toList();
    category.refresh();
  }


  void setDataOnInit({required GroundDetailModel data}) {

    clearData();
    if(data.categories != null && data.features != null && data.subGrounds != null)
    {
      timeStampForUpdate = data.timestamp;
      selectedCategoryValueItem = data.categories!.map((e) => (ValueItem(label: e.name.toString(), value:"0"))).toList();
      selectedCategory =data.categories!.map((element) => element.name ?? "").toList();
      mainGroundImageList.value.assignAll(data.mainGround!.image ?? <String>[]);
      mainGroundImgListForUpdate.assignAll(mainGroundImageList.value);

      ///
      groundNameController.text = data.mainGround?.name ?? "";
      latitudeController.text = data.mainGround!.latitude.toString();
      longitudeController.text = data.mainGround!.longitude.toString();
      taglineController.text = data.mainGround?.tagline ?? "";
      descriptionController.text = data.mainGround?.description ?? "";
      ///
      featuresList.value.assignAll(data.features!);
      // priceController.text = data.price!.toStringAsFixed(2);
      ///
      subGroundsList.value.assignAll(data.subGrounds!);
      for(SubGround subGround  in data.subGrounds ??[])
      {
        subGroundImgListForUpdate.add(subGround.image ?? []);
      }
      mainGroundImageList.refresh();
      featuresList.refresh();
      subGroundsList.refresh();
      update();
    }
  }



  Future timePicker(
      {required BuildContext context, type, required int index}) async {
    var selectedTime = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: appTheme.themeColor,
            colorScheme: ColorScheme.light(primary: appTheme.themeColor),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.normal),
          ),
          child: child!,
        );
      },
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (selectedTime != null) {
      // Format the time using the 'hh:mm a' pattern
      update(['add']);
      formattedTime = DateFormat('hh:mm a').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      ));
      update(['add']);

      if (type == 0) {
        fromTimePickerControllerList.value[index].text =
            formattedTime.toString();
        update(['add']);
        return formattedTime;
      } else {
        if (selectedTime.hour >
            DateFormat('hh:mm a')
                .parse(fromTimePickerControllerList.value[index].text)
                .hour) {
          toTimePickerControllerList.value[index].text =
              formattedTime.toString();
          update(['add']);
          return formattedTime;
        } else if (selectedTime.hour ==
            DateFormat('hh:mm a')
                .parse(fromTimePickerControllerList.value[index].text)
                .hour) {
          if (selectedTime.minute >
              DateFormat('hh:mm a')
                  .parse(fromTimePickerControllerList.value[index].text)
                  .minute) {
            toTimePickerControllerList.value[index].text =
                formattedTime.toString();
            update(['add']);
            return formattedTime;
          } else {
            errorToast("To time must be bigger that from time");
            update(['add']);
          }
        } else {
          errorToast("To time must be bigger that from time");
          update(['add']);
        }
      }
    }
    return null;
  }

  errorTextStyle() {
    return regularFontStyle(
      color: appTheme.red700,
      size: 15,
    );
  }



  String categoryError = '';

  categoryValidation() {
    if (selectedCategory.isNotEmpty) {
      categoryError = '';
    } else {
      categoryError = 'category_error'.tr;
    }
    update(["add"]);
  }

  RxString groundImgError = ''.obs;
  groundImageValidation() {
    if(mainGroundImageList.value.isEmpty)
    {
      groundImgError.value = 'groundImgError'.tr;
    }
    else{
      groundImgError.value = ''.tr;
    }
  }

  String groundNameError = '';

  groundNameValidation() {
    if (groundNameController.text.trim().isNotEmpty) {
      groundNameError = '';
    } else {
      groundNameError = 'ground_name_error'.tr;
    }
    update(["add"]);
  }

  String locationError = '';

  locationValidation() {
    if (latitudeController.text.trim().isNotEmpty &&
        longitudeController.text.trim().isNotEmpty) {
      locationError = '';
    } else {
      locationError = 'location_error'.tr;
    }
    update(["add"]);
  }

  String taglineError = '';

  taglineValidation() {
    if (taglineController.text.trim().isNotEmpty) {
      taglineError = '';
    } else {
      taglineError = 'tagline_error'.tr;
    }
    update(["add"]);
  }

  String descriptionError = '';

  descriptionValidation() {
    if (descriptionController.text.trim().isNotEmpty) {
      descriptionError = '';
    } else {
      descriptionError = 'description_error'.tr;
    }
    update(["add"]);
  }

  String featureError = '';

  featuresValidation() {
    if (featureController.text.trim().isNotEmpty) {

      if(featuresList.value.any((element) => element.name.toString().toLowerCase() == featureController.text.trim().toLowerCase()))
      {
        featureError = 'Feature already exists';
      }
      else{
        featureError = '';
        featuresList.value.add(Features(name: featureController.text.trim()));
        featureController.clear();
        featuresList.refresh();
      }

    } else {
      featureError = 'featureNameError'.tr;
    }
    update(["add"]);
  }

  emptyFeatureValidation(){
    if (featuresList.value.isEmpty) {
      featureError = 'Please add feature';
    } else {
      featureError = '';
    }
    update(["add"]);
  }
  emptySubGroundValidation(){
    if (subGroundsList.value.isEmpty) {
      subGroundError = 'Please add sub ground';
    } else {
      subGroundError = '';
    }
    update(["add"]);
  }
  String priceError = '';

  priceValidation() {
    if (priceController.text.trim().isNotEmpty) {
      priceError = '';
    } else {
      priceError = 'price_error'.tr;
    }
    update(["add"]);
  }

  String subGroundError = '';

  subGroundValidation({int? index,List<SubGround>? subGrounds}) {
    if ((subGroundImageList.value.isNotEmpty) &&
        subGroundName.text.trim().isNotEmpty &&
        priceController.text.trim().isNotEmpty &&
        durationController.text.trim().isNotEmpty &&
        !(fromTimePickerControllerList.value
            .any((element) => element.text.trim().isEmpty)) &&
        !(toTimePickerControllerList.value
            .any((element2) => element2.text.trim().isEmpty))) {
      if((double.tryParse(durationController.text.trim()) ?? 0) > 24)
      {
        subGroundError = "Duration should less then 24 hour";
      }
      else{
        List<TimeShift> shiftList = [];
        for (int i = 0; i < fromTimePickerControllerList.value.length; i++) {
          String fromTimeText = fromTimePickerControllerList.value[i].text.trim();
          String toTimeText = toTimePickerControllerList.value[i].text.trim();
          DateTime today = DateTime.now();
          DateTime fromTime = DateFormat('hh:mm a').parse(fromTimeText);
          DateTime toTime = DateFormat('hh:mm a').parse(toTimeText);
          DateTime fromDateTime = DateTime(today.year, today.month, today.day, fromTime.hour, fromTime.minute);
          DateTime toDateTime = DateTime(today.year, today.month, today.day, toTime.hour, toTime.minute);

          shiftList.add(TimeShift(from: fromDateTime, to: toDateTime));

        }
        if(subGroundsList.value.any((element) => element.name.toString().toLowerCase() == subGroundName.text.trim().toLowerCase() ) && isShiftUpdating.value == false )
        {
          subGroundError = 'Ground already exists';
        }
        else{
          if(isShiftUpdating.value)
          {
            List<String> imgList = [];
            imgList.addAll(subGroundImageList.value);
            Map<String,dynamic> subGroundMap = {
              'image': imgList,
              'timeShifts':[],
              'duration':double.tryParse(durationController.text.trim()) ?? 0,
              'name':subGroundName.text.trim(),
              'price': double.tryParse(priceController.text.trim()) ?? 0.0,
              'id':subGrounds != null ? subGrounds[selectedSubGroundIndex].id : "",
              'users':<User>[],
            };

            subGroundsList.value[selectedSubGroundIndex] =   SubGround.fromMap(subGroundMap);
            subGroundsList.value[selectedSubGroundIndex].timeShifts =   shiftList;

            subGroundsList.refresh();
          }
          else{
                   List<String> imgList = [];
                  imgList.addAll(subGroundImageList.value);
            Map<String,dynamic> subGroundMap = {
              'image': imgList,
              'timeShifts':[],
              'duration':double.tryParse(durationController.text.trim()) ?? 0,
              'name':subGroundName.text.trim(),
              'price': double.tryParse(priceController.text.trim()) ?? 0.0,
              'id':generateTimestampId(),
              'users':<User>[],
            };
            subGroundsList.value.add(SubGround.fromMap(subGroundMap));
            for(SubGround data in subGroundsList.value)
              {
                if(data.name.toString().toLowerCase() == subGroundName.text.trim().toLowerCase())
                  {
                    data.timeShifts = shiftList;
                  }
              }
            subGroundsList.refresh();
          }

          subGroundError = '';
          // singleGroundImageUrl.value = '';
          // selectedSubGImg.clear();
          durationController.clear();
          subGroundName.clear();
          priceController.clear();
          fromTimePickerControllerList.value = List.generate(1, (index) => TextEditingController());
          toTimePickerControllerList.value = List.generate(1, (index) => TextEditingController());
          subGroundImageList.value.clear();
          fromTimePickerControllerList.refresh();
          toTimePickerControllerList.refresh();
          subGroundImageList.refresh();
          isShiftUpdating.value = false;
        }
      }

    } else {
      subGroundError = 'sub_ground_error'.tr;
    }
    update(["add"]);
  }



  Future<void> clearData() async {
    selectedCategory.clear();
    selectedCategoryValueItem.clear();
    mainGroundImageList.clear();
    featuresList.clear();
    subGroundsList.clear();
    groundNameController.clear();
    latitudeController.clear();
    longitudeController.clear();
    taglineController.clear();
    descriptionController.clear();
    featureController.clear();
    priceController.clear();
    subGroundName.clear();
    durationController.clear();
    subGroundImageList.value.clear();
    // singleGroundImageUrl.value = "";
    // selectedSubGImg.clear();
    fromTimePickerControllerList.value = List.generate(1, (index) => TextEditingController());
    toTimePickerControllerList.value = List.generate(1, (index) => TextEditingController());
    fromTimePickerControllerList.refresh();
    toTimePickerControllerList.refresh();
    timeStampForUpdate = null;
    selectedCategoryValueItem.clear();
    subGroundImageList.refresh();
    loader.value = true;
    await Future.delayed(Duration(milliseconds: 500),(){});
    loader.value = false;
    update();
  }

  Future<List<String>> uploadImagesToFirebaseStorage(
      {required List<String> base64Images}) async {
    loader.value = true;
    List<String> downloadUrls = [];

    try {

      for (final String image in base64Images) {
        if(image.contains("https://") ){
          downloadUrls.add(image);
        }
        else{
          String base64Data = image.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
          final String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

          List<int> bytes = base64Decode(base64Data);

          // Get a reference to the Firebase Storage location
          Reference storageReference = FirebaseStorage.instance
              .ref(Keys.admin)
              .child(Keys.groundDetails)
              .child('images/$fileName');

          // Upload the bytes to Firebase Storage
          UploadTask uploadTask =
          storageReference.putData(Uint8List.fromList(bytes));
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

          // Get the download URL of the uploaded image
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
          print(downloadUrl);
        }

      }

      loader.value = false;
      return downloadUrls;
    } catch (error) {
      print("Error uploading images: $error");
      errorToast("Error uploading image");
      loader.value = false;
      return [];
    }
  }




  Future<void> deleteFileFromFirebaseStorage(String url) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
      print('File deleted successfully');
    } catch (e) {
      print('Error deleting file: $e');
    }
  }


  Future<void> insertGroundDetails(
      {required VoidCallback onSuccess}) async {
    try {
      loader.value = true;
      if(allGroundDetailController.groundDetailList.value.any((element) => element.mainGround!.name.toString().toLowerCase() == groundNameController.text.trim().toLowerCase()))
      {
        errorToast("Ground already exists");
      }
      else{
        List<String> mainGroundImgUrl =
        await uploadImagesToFirebaseStorage(base64Images: mainGroundImageList.value);
        // Feature's icon upload
        // await uploadImagesToFirebaseStorage(base64Images: mainGroundImageList.value);
        List<String> imageUrls = [];
        subGroundsList.value.forEach((element) { imageUrls.addAll(element.image ?? []);});
        List<String> subGroundImgUrl =  await uploadImagesToFirebaseStorage(base64Images: imageUrls);
        if (mainGroundImgUrl.isNotEmpty && subGroundImgUrl.isNotEmpty) {
          List<Category> categoryList = [];
          selectedCategory.forEach((element) { categoryList.add(Category(name: element));});
          MainGround mainGround = MainGround(
            name: groundNameController.text,
            image: mainGroundImgUrl,
            latitude: double.tryParse(latitudeController.text.trim()) ?? 00.0000000,
            longitude: double.tryParse(longitudeController.text.trim()) ?? 00.0000000,
            tagline: taglineController.text.trim(),
            description: descriptionController.text.trim(),
          );

          // check here uploaded imag and original list length
          for(int i=0; i< subGroundsList.value.length; i++)
          {
            // if(subGroundImgUrl.length == subGroundList.value.length)
            // {
            subGroundsList.value[i].image = subGroundImgUrl;
            // }
            // else{
            //   errorToast("Error while uploading image");
            //   return;
            // }
          }

          ///    Selected category ID
          List<String> selectedCategoryId = [];
          for(int i=0; i< logoIconController.sportIconList.value.length;i++)
          {
            for(int j=0; j<categoryList.length;j++)
            {
              if(logoIconController.sportIconList.value[i].name == categoryList[j].name)
              {
                selectedCategoryId.add(logoIconController.sportIconList.value[i].id ??"");
              }
            }
          }

          GroundDetailModel groundDetailData = GroundDetailModel(
            categories:categoryList,
            features: featuresList.value,
            mainGround: mainGround,
            subGrounds: subGroundsList.value,
            timestamp: DateTime.now(),
            categoryIdList: selectedCategoryId,
            review: [],
            // logoIconController.sportIconList.value.map((element) => element.id ?? "").toList()
          );

          await FirebaseFirestore.instance
              .collection(Keys.admin)
              .doc(Keys.groundDetails)
              .collection(Keys.groundDetails)
              .doc()
              .set(groundDetailData.toMap());
          await allGroundDetailController.init();
          await clearData();
          onSuccess();

        }

      }


      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("upload error -------->>>>: $e");
    }
  }



  Future<void> updateGroundDetails(
      {required VoidCallback onSuccess,required GroundDetailModel stadiumData}) async {
    try {
      loader.value = true;
      if(allGroundDetailController.groundDetailList.value.any((element) => element.mainGround!.name.toString().toLowerCase() == groundNameController.text.trim().toLowerCase() && element.timestamp != timeStampForUpdate))
      {
        errorToast("Ground already exists");
      }
      else{
        await Future.delayed(Duration(seconds: 1),(){});
        for(int i=0; i<mainGroundImgListForUpdate.length;i++)
        {
          if(!( mainGroundImageList.value.any((element) => mainGroundImgListForUpdate[i] == element)))
          {
            await deleteFileFromFirebaseStorage(mainGroundImgListForUpdate[i]);
            debugPrint("File deleted ---------------------");
          }
        }


        for(int i=0; i<subGroundImgListForUpdate.length;i++)
        {
          if(!( subGroundsList.value.any((element) => subGroundImgListForUpdate[i] == element.image)))
          {
            for(String image in subGroundImgListForUpdate[i])
            {
              await deleteFileFromFirebaseStorage(image);
            }
            debugPrint("File deleted ---------------------");
          }
        }


        List<String> mainGroundImgUrl =
        await uploadImagesToFirebaseStorage(base64Images: mainGroundImageList.value);
        // Feature's icon upload
        // await uploadImagesToFirebaseStorage(base64Images: mainGroundImageList.value);
        List<List<String>> imageUrls = List.generate(subGroundsList.value.length, (index) => subGroundsList.value[index].image ?? <String>[]);

        if (mainGroundImgUrl.isNotEmpty ) {
          List<Category> categoryList = [];
          selectedCategory.forEach((element) { categoryList.add(Category(name: element));});
          MainGround mainGround = MainGround(
            name: groundNameController.text,
            image: mainGroundImgUrl,
            latitude: double.tryParse(latitudeController.text.trim()) ?? 00.0000000,
            longitude: double.tryParse(longitudeController.text.trim()) ?? 00.0000000,
            tagline: taglineController.text.trim(),
            description: descriptionController.text.trim(),
          );
          debugPrint("------------: ===================++++++++++++");
          // check here uploaded imag and original list length
          for(int i=0; i< subGroundsList.value.length; i++)
          {

            subGroundsList.value[i].image=  await uploadImagesToFirebaseStorage(base64Images: imageUrls[i]);
            if( (subGroundsList.value[i].image??[]).isEmpty)
            {
                errorToast("Error while uploading image");
                break;
            }
          }

          ///    Selected category ID
          List<String> selectedCategoryId = [];
          for(int i=0; i< logoIconController.sportIconList.value.length;i++)
          {
            for(int j=0; j<categoryList.length;j++)
            {
              if(logoIconController.sportIconList.value[i].name == categoryList[j].name)
              {
                selectedCategoryId.add(logoIconController.sportIconList.value[i].id ??"");
              }
            }
          }
          debugPrint("------------: ===================");
          GroundDetailModel groundDetailData = GroundDetailModel(
            categories:categoryList,
            features: featuresList.value,
            mainGround: mainGround,
            subGrounds: subGroundsList.value,
            timestamp: DateTime.now(),
            categoryIdList: selectedCategoryId,
            review: stadiumData.review,
            // logoIconController.sportIconList.value.map((element) => element.id ?? "").toList()
          );

          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection(Keys.admin)
              .doc(Keys.groundDetails)
              .collection(Keys.groundDetails)
              .where(Keys.timestamp, isEqualTo: timeStampForUpdate)
              .get();
          debugPrint("------------: ${querySnapshot.docs.first.data()}");
          if (querySnapshot.docs.isNotEmpty) {


            await FirebaseFirestore.instance
                .collection(Keys.admin)
                .doc(Keys.groundDetails)
                .collection(Keys.groundDetails).doc(querySnapshot.docs.first.id)
                .update(groundDetailData.toMap());
            onSuccess();
            await clearData();
            await allGroundDetailController.init();


          } else {
            errorToast("Stadium details not found");
          }
        }
      }


      loader.value = false;
    } catch (e) {
      loader.value = false;
      log("upload error -------->>>>: $e");
    }
  }





}
