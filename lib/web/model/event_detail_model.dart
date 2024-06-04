

import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailModel {
  final String name;
  final List<String> eventImages;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? fromTime;
  final DateTime? toTime;
  final double price;
  final String description;
  final List<String> preMemoryImages;
  final DateTime timestamp;
  final String? url;

  EventDetailModel(
      {required this.name,
      required this.eventImages,
      required this.startDate,
      required this.endDate,
      this.fromTime,
      this.toTime,
      required this.preMemoryImages,
      required this.price,
      required this.timestamp,required this.description,required this.url});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'eventImages': eventImages  ,
      'startDate': startDate,
      'endDate': endDate,
      'fromTime': fromTime,
      'toTime': toTime,
      'preMemoryImages': preMemoryImages,
      'price': price,
      'description': description,
      'timestamp': timestamp,
      'url':url
    };
  }

  factory EventDetailModel.fromMap(Map<String, dynamic> map) {
    return EventDetailModel(
      name: map['name'],
      eventImages:/* map['eventImages']*/      (map['eventImages'] as List<dynamic>).cast<String>(),
      startDate:map['startDate'] != null ? (map['startDate'] as Timestamp).toDate() : DateTime.now(),
      endDate:map['endDate'] != null ? (map['endDate'] as Timestamp).toDate() : DateTime.now(),
      fromTime:map['fromTime'] != null ? (map['fromTime'] as Timestamp).toDate() : DateTime.now(),
      toTime:map['toTime'] != null ? (map['toTime'] as Timestamp).toDate() : DateTime.now(),
      description: map['description'],
      preMemoryImages:/* map['preMemoryImages']   */  (map['preMemoryImages'] as List<dynamic>).cast<String>(),
      price: map['price'],
      timestamp: map['timestamp'] != null ? (map['timestamp'] as Timestamp).toDate() : DateTime.now(),
      url: map['url'],
    );
  }
}
