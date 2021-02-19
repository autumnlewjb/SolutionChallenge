import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'Models/return_info.dart';
import 'Models/user.dart';

class Database {
  static CollectionReference userDB =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference rewardDB =
      FirebaseFirestore.instance.collection('rewards');
  static CollectionReference schDB = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('schedule');
  static CollectionReference claimedRewardDB = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('rewards');

  static Future<void> addSch(ReturnInfo info) async {
    return await schDB.doc(info.timeCreated).set({
      'medicine': info.medName,
      'expiryDate': info.expiryDate,
      'address1': info.address1,
      'address2': info.address2,
      'state': info.state,
      'postcode': info.postcode,
      'status': info.status,
      'timeCreated': info.timeCreated
    });
  }

  static Future<void> deleteSch(String id) async {
    return await schDB.doc(id).delete();
  }

  static Stream<List<ReturnInfo>> getReturnInfo() {
    return schDB.orderBy('timeCreated', descending: true).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ReturnInfo.fromMap(doc.data()))
            .toList());
  }

  static Future<void> addUser(String uid, AppUser appUser) async {
    var val = userDB.doc(uid).set({
      'first_name': appUser.firstName,
      'last_name': appUser.lastName,
      'username': appUser.username,
      'email': appUser.email,
      'address1': appUser.address1,
      'address2': appUser.address2,
      'state': appUser.state,
      'postcode': appUser.postcode,
      'reward_points': 0,
    });
    print(val);
    return val;
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    var val = userDB.doc(uid).update(data);
    return val;
  }

  static Future<DocumentSnapshot> getUser(String uid) async {
    DocumentSnapshot snapshot = await userDB.doc(uid).get();
    if (snapshot.exists) {
      return snapshot;
    }

    return null;
  }

  static Stream<DocumentSnapshot> getUserStream(String uid) {
    Stream<DocumentSnapshot> stream = userDB.doc(uid).snapshots();

    return stream;
  }

  static Future<List<DocumentSnapshot>> getAllHospitals() async {
    QuerySnapshot snapshots = await rewardDB.get();

    return snapshots.docs;
  }

  static Future<List<DocumentSnapshot>> getServices(String doc_id) async {
    QuerySnapshot snapshots =
        await rewardDB.doc(doc_id).collection("offers").get();

    return snapshots.docs;
  }

  static Stream<DocumentSnapshot> getRewardDetails(
      String hospitalId, String rewardId) {
    return rewardDB
        .doc(hospitalId)
        .collection("offers")
        .doc(rewardId)
        .snapshots();
  }

  static Future<void> addClaimedReward(DocumentReference reference) async {
    return await claimedRewardDB.doc(DateTime.now().toString()).set({
      'hospitalId': reference.parent.parent.id,
      'rewardId': reference.id,
      'timeClaimed': DateFormat.yMMMd().add_jm().format(DateTime.now())
    });
  }
}
