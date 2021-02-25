import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableReward {
  DocumentReference reference;
  String title;
  String description;
  int cost;

  AvailableReward({this.reference, this.title, this.description, this.cost});

  factory AvailableReward.fromMap(Map data, DocumentReference reference) {
    return AvailableReward(
        reference: reference,
        title: data['title'] ?? 'N/A',
        description: data['description'] ?? 'N/A',
        cost: data['cost'] ?? double.nan);
  }
}
