import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:return_med/return_info.dart';

class Database {
  CollectionReference schDB = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('schedule');

  Future<void> updateSchDB(ReturnInfo info) async {
    return await schDB.doc(DateTime.now().toString()).set({
      'medicine': info.medName,
      'expiry date': info.selectedDate,
      'address1': info.address1,
      'address2': info.address2,
      'state': info.state,
      'postcode': info.postcode,
      'time created': DateTime.now().toString(),
      'status': 'pending'
    });
  }
}
