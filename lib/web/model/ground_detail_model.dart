import 'package:cloud_firestore/cloud_firestore.dart';

class GroundDetailModel {
  final List<Category>? categories;
  final MainGround? mainGround;
  final List<Features>? features;
  final List<SubGround>? subGrounds;
  final DateTime timestamp;
  final List<String>? categoryIdList;
  List? review;


  GroundDetailModel({
    this.categories,
    this.mainGround,
    this.features,
    this.subGrounds,
    required this.timestamp,
    this.categoryIdList,
    this.review
  });

  Map<String, dynamic> toMap() {
    return {
      'categories': categories != null ? categories!.map((category) => category.toMap()).toList() : null,
      'mainGround': mainGround != null ? mainGround!.toMap() : null,
      'features': features != null ? features!.map((feature) => feature.toMap()).toList() : null,
      'subGrounds':subGrounds != null ? subGrounds!.map((subGround) => subGround.toMap()).toList() : null,
      'timestamp': timestamp,
      'categoryIdList': categoryIdList,
      'review': review
    };
  }

  factory GroundDetailModel.fromMap(Map<String, dynamic> map) {
    return GroundDetailModel(
      categories: map['categories'] != null ? List<Category>.from(map['categories'].map((x) => Category.fromMap(x))) : null,
      mainGround: map['mainGround'] != null ? MainGround.fromMap(map['mainGround']) : null,
      features: map['features'] != null ? List<Features>.from(map['features'].map((x) => Features.fromMap(x))) : null,
      subGrounds:map['subGrounds'] != null ? List<SubGround>.from(map['subGrounds'].map((x) => SubGround.fromMap(x))) : null,
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
      categoryIdList: map['categoryIdList'] != null ? List<String>.from(map['categoryIdList']) : null,
      review: map['review'] != null ? List.from(map['review']) : null,
    );
  }
}




class Category {
  final String name;
  final String? image;

  Category({required this.name, this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      image: map['image'],
    );
  }
}

class Features {
  final String name;
  final String? image;

  Features({required this.name, this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory Features.fromMap(Map<String, dynamic> map) {
    return Features(
      name: map['name'],
      image: map['image'],
    );
  }
}

class MainGround {
  final List<String>? image;
  final String? name;
  final double? latitude;
  final double? longitude;
  final String? tagline;
  final String? description;

  MainGround({
    this.image,
    this.name,
    this.latitude,
    this.longitude,
    this.tagline,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'tagline': tagline,
      'description': description,
    };
  }

  factory MainGround.fromMap(Map<String, dynamic> map) {
    return MainGround(
      image: map['image'] != null ? List<String>.from(map['image']) : null,
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      tagline: map['tagline'],
      description: map['description'],
    );
  }
}

class TimeShift {
  final DateTime? from;
  final DateTime? to;

  TimeShift({this.from, this.to});

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
    };
  }

  factory TimeShift.fromMap(Map<String, dynamic> map) {
    return TimeShift(
      from: map['from'] != null ? (map['from'] as Timestamp).toDate() : null,
      to: map['to'] != null ? (map['to'] as Timestamp).toDate() : null,
    );
  }
}

class SubGround {
  List<String>? image;
   List<TimeShift>? timeShifts;
  final String name;
  final double duration;
  final double price;
  final String id;
  List<User>? users;


  SubGround({
    this.image,
    this.timeShifts,
    required this.name,
    required this.duration,
    required this.price,
    required this.id,
    this.users
  });

  Map<String, dynamic> toMap() {
    return {
      'image':  image,
      'timeShifts': timeShifts != null ? timeShifts!.map((timeShift) => timeShift.toMap()).toList() : null,
      'duration': duration.toDouble(),
      'name': name,
      'price': price.toDouble(),
      'id':id,
      'users':users != null ? users!.map((user) => user.toMap()).toList() : null,
    };
  }

  factory SubGround.fromMap(Map<String, dynamic> map) {
    // List<String>? imagesList;
    // print("Images data from map: ${map['images']}"); // Debugging line
    // if (map.containsKey('images') && map['images'] != null) {
    //   dynamic imagesData = map['images'];
    //   if (imagesData is String) {
    //     // If single image string is returned, convert it to a list
    //     imagesList = [imagesData];
    //   } else if (imagesData is List<dynamic> || imagesData is List<String>) {
    //     // If list of images is returned, use it directly
    //     imagesList = List<String>.from(imagesData);
    //   }
    // }

    return SubGround(
      image: map['image']  != null ? List<String>.from(map['image']) : null,
      timeShifts: map['timeShifts'] != null ? List<TimeShift>.from(map['timeShifts'].map((x) => TimeShift.fromMap(x))) : null,
      name: map['name'],
      duration: map['duration'].toDouble(),
      price: map['price'].toDouble(),
      id: map['id'] == null ? "":map['id'],
      users: map['users'] != null ? List<User>.from(map['users'].map((x) => User.fromMap(x))) : null,
    );
  }
}


class User {
  final String uid;
  List<String> bookingId;
  User({required this.uid, required this.bookingId});
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'bookingId': bookingId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      bookingId:List<String>.from(map['bookingId']),
    );
  }
}



