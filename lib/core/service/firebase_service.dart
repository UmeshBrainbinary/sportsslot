import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsslot/core/utils/firebaseKeys.dart';

class FirebaseService {



    static var categoryCollection = FirebaseFirestore.instance
        .collection(FirebaseKey.admin)
        .doc(FirebaseKey.sportIcon)
        .collection(FirebaseKey.sportIcon);
    static var groundListCollection = FirebaseFirestore.instance
        .collection(FirebaseKey.admin)
        .doc(FirebaseKey.groundDetails)
        .collection(FirebaseKey.groundDetails);
    static var eventListCollection = FirebaseFirestore.instance
        .collection(FirebaseKey.admin)
        .doc(FirebaseKey.events)
        .collection(FirebaseKey.events);

}
