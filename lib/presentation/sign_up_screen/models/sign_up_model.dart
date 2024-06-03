/// This class defines the variables used in the [sign_up_screen],
/// and is typically used to hold data that is passed between different parts of the application.


class SignUpModel {

  final String role;
  final String firstName;
  final String lastName;
  final String dob;
  final String mobileNo;
  final String email;
  final String password;
  final String fcmToken;

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.mobileNo,
    required this.role,
    required this.email,
    required this.password,
    required this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'mobileNo': mobileNo,
      'role': role,
      'email': email,
      'password': password,
      'fcmToken': fcmToken,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      dob: map['dob'],
      mobileNo: map['mobileNo'],
      role: map['role'],
      email: map['email'],
      password: map['password'],
      fcmToken: map['fcmToken']
    );
  }
}

