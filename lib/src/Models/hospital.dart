import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  DocumentReference reference;
  String name;
  String address;

  Hospital({this.reference, this.name, this.address});

  factory Hospital.fromMap(Map data, DocumentReference reference) {
    return Hospital(
        reference: reference,
        name: data['name'] ?? 'N/A',
        address: data['address'] ?? 'N/A');
  }
}
