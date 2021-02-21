import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:return_med/Models/available_reward.dart';

class Hospital {
  DocumentReference reference;
  String name;
  String address;
  Stream<List<AvailableReward>> reward;

  Hospital({this.reference, this.name, this.address, this.reward});

  factory Hospital.fromMap(Map data, DocumentReference reference,
      Stream<List<AvailableReward>> reward) {
    return Hospital(
        reference: reference,
        name: data['name'] ?? 'N/A',
        address: data['address'] ?? 'N/A',
        reward: reward ?? []);
  }
}
