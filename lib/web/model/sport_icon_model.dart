import 'package:cloud_firestore/cloud_firestore.dart';

class SportIconModel {
  final String name;
  final String image;
  final DateTime timestamp;
  final String? nameId;
  final String? id;

  SportIconModel( {
    required this.name,
    required this.image,
    required this.timestamp,
     this.nameId,
    this.id
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'timestamp': timestamp,
      'nameId': nameId,
      'id': id,
    };
  }

  factory SportIconModel.fromMap(Map<String, dynamic> map) {
    return SportIconModel(
      name: map['name'],
      image: map['image'],
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
      nameId: map['nameId'],
      id: map['id'],
    );
  }
}
