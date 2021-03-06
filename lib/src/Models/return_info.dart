import 'package:intl/intl.dart';

class ReturnInfo {
  String medName;
  String expiryDate;
  String address1;
  String address2;
  String state;
  String postcode;
  String status;
  String timeCreated;
  String pic;

  ReturnInfo(
      {this.medName,
      this.expiryDate,
      this.address1,
      this.address2,
      this.state,
      this.postcode,
      this.status,
      this.timeCreated,
      this.pic});

  factory ReturnInfo.fromMap(Map data) {
    return ReturnInfo(
        medName: data['medicine'] ?? 'N/A',
        expiryDate: data['expiryDate'] ?? 'N/A',
        address1: data['address1'] ?? 'N/A',
        address2: data['address2'] ?? 'N/A',
        state: data['state'] ?? 'N/A',
        postcode: data['postcode'] ?? 'N/A',
        status: data['status'] ?? 'N/A',
        timeCreated: data['timeCreated'] ?? 'N/A',
        pic: data['pic'] ?? 'N/A');
  }

  factory ReturnInfo.toMap(String medName, DateTime expiryDate, String address1,
      String address2, String state, String postcode) {
    return ReturnInfo(
        medName: medName,
        expiryDate: DateFormat.yMMMd().format(expiryDate),
        address1: address1,
        address2: address2,
        state: state,
        postcode: postcode,
        status: 'Pending',
        timeCreated: DateFormat.yMMMd().add_jm().format(DateTime.now()));
  }
}
