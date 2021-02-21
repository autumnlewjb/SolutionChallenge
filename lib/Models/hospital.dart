import 'package:return_med/Models/available_reward.dart';

class Hospital {
  String id;
  String name;
  String address;
  List<AvailableReward> reward;

  Hospital({this.id, this.name, this.address, this.reward});

  factory Hospital.fromMap(Map data, String id) {
    return Hospital(
      id: id,
      name: data['name'] ?? 'N/A',
      address: data['address'] ?? 'N/A',
    );
  }
}
