import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:return_med/src/models/available_reward.dart';
import 'package:return_med/src/models/user_reward.dart';

import '../models/hospital.dart';
import '../models/return_info.dart';
import '../models/user.dart';

class Database {
  static CollectionReference userDB =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference rewardDB =
      FirebaseFirestore.instance.collection('rewards');
  static Query scheduleGroup =
      FirebaseFirestore.instance.collectionGroup('schedule');

  static Future<DocumentSnapshot> getUser(String uid) async {
    DocumentSnapshot snapshot = await userDB.doc(uid).get();
    if (snapshot.exists) {
      return snapshot;
    }

    return null;
  }

  static Stream<AppUser> getUserStream(String uid) {
    print(uid);
    return userDB.doc(uid).snapshots().map((snapshot) => AppUser.fromMap(uid,
        snapshot.data(), FirebaseAuth.instance.currentUser?.photoURL ?? ""));
  }

  static Stream<List<ReturnInfo>> getReturnInfo(String uid) {
    return userDB
        .doc(uid)
        .collection('schedule')
        .orderBy('timeCreated', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ReturnInfo.fromMap(doc)).toList());
  }

  static Stream<List<ReturnInfo>> getAllReturnInfo() {
    return scheduleGroup
        .orderBy("timeCreated", descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ReturnInfo.fromMap(doc)).toList());
  }

  static Future<String> getUsernameFromReturnInfo(String returnDocId) async {
    return await FirebaseFirestore.instance
        .collection("schedule")
        .doc(returnDocId)
        .parent
        .parent
        .get()
        .then((userDoc) => userDoc.data()['username']);
  }

  static Stream<List<UserReward>> getClaimedReward(String uid) {
    return userDB
        .doc(uid)
        .collection("rewards")
        .orderBy('timeClaimed', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserReward.fromMap(doc.data(), doc.reference))
            .toList());
  }

  static Stream<List<Hospital>> getHospitals() {
    return rewardDB.orderBy('name').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Hospital.fromMap(doc.data(), doc.reference))
        .toList());
  }

  static Future<List<AvailableReward>> getAvailableReward(String id) {
    return rewardDB.doc(id).collection("offers").orderBy('cost').get().then(
        (snapshot) => snapshot.docs
            .map((doc) => AvailableReward.fromMap(doc.data(), doc.reference))
            .toList());
  }

  static void updateReturnStatus(String scheduleId, String newStatus) async {
    scheduleGroup.where("doc.id").get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        if (doc.id == scheduleId) {
          switch (newStatus) {
            case "Completed":
              doc.reference.update({
                'status': newStatus,
              });
              break;
            case "Pending":
              doc.reference.update({
                'status': newStatus,
                'pic': null,
              });
              break;
            case "Accepted":
              doc.reference.update({
                'status': newStatus,
                'pic': FirebaseAuth.instance.currentUser.uid
              });
          }
        }
      });
    });
  }

  static Future<void> addUser(AppUser appUser) async {
    var val = userDB.doc(appUser.uid).set({
      'first_name': appUser.firstName,
      'last_name': appUser.lastName,
      'username': appUser.username,
      'email': appUser.email,
      'address1': appUser.address1,
      'address2': appUser.address2,
      'state': appUser.state,
      'postcode': appUser.postcode,
      'photoUrl': appUser.photoUrl,
      'reward_points': appUser.rewardPoint,
    }, SetOptions(merge: true));
    return val;
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    var val = userDB.doc(uid).update(data);
    return val;
  }

  static Future<void> addSch(String uid, ReturnInfo info) async {
    return await userDB
        .doc(uid)
        .collection('schedule')
        .doc(info.timeCreated)
        .set({
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
    return await userDB
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('schedule')
        .doc(id)
        .delete();
  }

  static Future<void> addClaimedReward(
      String uid, AvailableReward reward) async {
    return await userDB
        .doc(uid)
        .collection("rewards")
        .doc(DateTime.now().toString())
        .set({
      'hospitalId': reward.reference.parent.parent.id,
      'rewardId': reward.reference.id,
      'title': reward.title,
      'description': reward.description,
      'timeClaimed': DateFormat.yMMMd().add_jm().format(DateTime.now())
    });
  }
}
