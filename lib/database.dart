import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:return_med/Models/available_reward.dart';

import 'Models/hospital.dart';
import 'Models/return_info.dart';
import 'Models/user.dart';

class Database {
  /*final FirebaseFirestore _firestore;
  CollectionReference userDB;
  CollectionReference rewardDB;
  CollectionReference schDB;
  CollectionReference claimedRewardDB;

  Database(this._firestore,_firebaseAuth){

  }*/
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

  static Future<DocumentSnapshot> getUser(String uid) async {
    DocumentSnapshot snapshot = await userDB.doc(uid).get();
    if (snapshot.exists) {
      return snapshot;
    }

    return null;
  }

  static Stream<AppUser> getUserStream(String uid) {
    return userDB
        .doc(uid)
        .snapshots()
        .map((snapshot) => AppUser.fromMap(snapshot.data()));
  }

  static Stream<List<ReturnInfo>> getReturnInfo() {
    return schDB.orderBy('timeCreated', descending: true).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ReturnInfo.fromMap(doc.data()))
            .toList());
  }

  static Stream<List<Hospital>> getHospitals() {
    return rewardDB.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Hospital.fromMap(doc.data(), doc.id))
        .toList());
  }

  static Stream<List<AvailableReward>> getRewardStream(String hospitalId) {
    Stream<List<AvailableReward>> stream = rewardDB
        .doc(hospitalId)
        .collection("offers")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AvailableReward.fromMap(doc.data(), doc.id))
            .toList());
    return stream;
    /*List<AvailableReward> avai;
    stream.listen((data) {
      avai=data;
    });
    return avai;*/
  }

  /*static Stream<List<AvailableReward>> getRewardStream(
      String hospitalId, String rewardId) {
    return rewardDB
        .doc(hospitalId)
        .collection("offers")
        .doc(rewardId)
        .snapshots();
  }*/

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
    });
    return val;
  }

  static Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    var val = userDB.doc(uid).update(data);
    return val;
  }

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

  static Future<List<DocumentSnapshot>> getAllHospitals() async {
    QuerySnapshot snapshots = await rewardDB.get();

    return snapshots.docs;
  }

  static Future<List<DocumentSnapshot>> getServices(String doc_id) async {
    QuerySnapshot snapshots =
        await rewardDB.doc(doc_id).collection("offers").get();

    return snapshots.docs;
  }

  static Future<void> addClaimedReward(DocumentReference reference) async {
    return await claimedRewardDB.doc(DateTime.now().toString()).set({
      'hospitalId': reference.parent.parent.id,
      'rewardId': reference.id,
      'timeClaimed': DateFormat.yMMMd().add_jm().format(DateTime.now())
    });
  }
}
