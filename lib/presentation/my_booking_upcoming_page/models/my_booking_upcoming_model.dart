/// This class defines the variables used in the [my_booking_upcoming_page],
/// and is typically used to hold data that is passed between different parts of the application.
class MyBookingUpcomingModel {
  String? id;
  String? stadiumId;
  String? image;
  String? title;
  String? selectedDate;
  String? registerDateTime;
  dynamic latitude;
  dynamic longitude;
  String? subGround;
  String? subGroundId;
  String? bookingCode;
  String? date;
  String? time;
  String? price;
  bool? isCancelBooking;
  MyBookingUpcomingModel(
      {this.id,
        this.stadiumId,
      this.image,
      this.title,
      this.selectedDate,
      this.registerDateTime,
      this.latitude,
      this.longitude,
      this.subGround,
        this.subGroundId,
      this.bookingCode,
      this.date,
      this.time,
      this.price,
        this.isCancelBooking
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stadiumId': stadiumId,
      'image': image,
      'title': title,
      'selectedDate': selectedDate,
      'registerDateTime': registerDateTime,
      'latitude': latitude,
      'longitude': longitude,
      'subGround': subGround,
      'subGroundId': subGroundId,
      'bookingCode': bookingCode,
      'date': date,
      'time': time,
      'price': price,
      'isCancelBooking': isCancelBooking
    };
  }
}
