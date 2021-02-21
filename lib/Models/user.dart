import 'package:flutter/material.dart';

class AppUser with ChangeNotifier {
  String uid;
  String firstName;
  String lastName;
  String username;
  String email;
  String address1;
  String address2;
  String state;
  String postcode;
  String photoUrl;
  String rewardPoint;

  AppUser(
      {this.uid = 'N/A',
      this.firstName = 'N/A',
      this.lastName = 'N/A',
      this.username = 'N/A',
      this.email = 'N/A',
      this.address1 = 'N/A',
      this.address2 = 'N/A',
      this.state = 'N/A',
      this.postcode = 'N/A',
      this.photoUrl = '',
      this.rewardPoint = '0'});

  factory AppUser.fromMap(Map data) {
    return AppUser(
        firstName: data['first_name'] ?? 'N/A',
        lastName: data['last_name'] ?? 'N/A',
        username: data['username'] ?? 'N/A',
        email: data['email'] ?? 'N/A',
        address1: data['address1'] ?? 'N/A',
        address2: data['address2'] ?? 'N/A',
        state: data['state'] ?? 'N/A',
        postcode: data['postcode'] ?? 'N/A',
        photoUrl: data['photoUrl'] ?? '',
        rewardPoint: data['reward_points'] ?? '0');
  }
}
