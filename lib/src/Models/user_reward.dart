import 'package:cloud_firestore/cloud_firestore.dart';

class UserReward {
  DocumentReference reference;
  String hospitalId;
  String rewardId;
  String title;
  String description;
  String timeClaimed;

  UserReward(
      {this.hospitalId,
      this.rewardId,
      this.title,
      this.description,
      this.timeClaimed,
      this.reference});

  factory UserReward.fromMap(Map data, DocumentReference reference) {
    return UserReward(
        reference: reference,
        hospitalId: data['hospitalId'] ?? 'N/A',
        rewardId: data['rewardId'] ?? 'N/A',
        title: data['title'] ?? 'N/A',
        description: data['description'] ?? 'N/A',
        timeClaimed: data['timeClaimed'] ?? 'N/A');
  }
}
