import 'package:sportsslot/presentation/detail_screen/models/ground_list_model.dart';

class BookingModel {
  String stadiumName;
  List image;
  double latitude;
  double longitude;
  DateTime selectDate;
  String selectTime;
  String stadiumId;
  SubGroundDetail subGroundDetail;
  String bookingCode;
  DateTime registerTime;
  UserDetail userDetail;
  String id;
  String member;
  bool isCancelBooking;

  BookingModel({
    required this.stadiumName,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.selectDate,
    required this.selectTime,
    required this.stadiumId,
    required this.subGroundDetail,
    required this.bookingCode,
    required this.registerTime,
    required this.userDetail,
    required this.id,
    required this.member,
    required this.isCancelBooking,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      stadiumName: map['stadiumName'],
      image: map['image'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      selectDate: DateTime.parse(map['selectDate']),
      selectTime: map['selectTime'],
      stadiumId: map['stadiumId'],
      subGroundDetail: SubGroundDetail.fromMap(map['subGroundDetail']),
      bookingCode: map['bookingCode'],
      registerTime: DateTime.parse(map['registerTime']),
      userDetail: UserDetail.fromMap(map['userDetail']),
      id: map['id'],
      member: map['member'],
      isCancelBooking: map['isCancelBooking'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stadiumName': stadiumName,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'selectDate': selectDate,
      'selectTime': selectTime,
      'stadiumId': stadiumId,
      'subGroundDetail': subGroundDetail.toMap(),
      'bookingCode': bookingCode,
      'registerTime': registerTime,
      'userDetail': userDetail.toMap(),
      'id': id,
      'member': member,
      'isCancelBooking': isCancelBooking
    };
  }
}




class SubGroundDetail {
  String subGroundId;
  String subGroundName;
  String price;
  String image;

  SubGroundDetail({required this.subGroundId, required this.subGroundName, required this.price, required this.image});

  factory SubGroundDetail.fromMap(Map<String, dynamic> map) {
    return SubGroundDetail(
      subGroundId: map['subGroundId'],
      subGroundName: map['subGroundName'],
      price: map['price'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subGroundId': subGroundId,
      'subGroundName': subGroundName,
      'price': price,
      'image': image,
    };
  }
}

class UserDetail {
  String userEmail;
  String userId;
  String userName;
  String userMobile;

  UserDetail({required this.userEmail, required this.userId, required this.userName, required this.userMobile});

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      userEmail: map['userEmail'],
      userId: map['userId'],
      userName: map['userName'],
      userMobile: map['userMobile'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEmail': userEmail,
      'userId': userId,
      'userName': userName,
      'userMobile': userMobile,
    };
  }
}

