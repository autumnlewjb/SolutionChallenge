class AvailableReward {
  String id;
  String title;
  String description;
  int cost;

  AvailableReward({this.id, this.title, this.description, this.cost});

  factory AvailableReward.fromMap(Map data, String id) {
    return AvailableReward(
        id: id,
        title: data['title'] ?? 'N/A',
        description: data['description'] ?? 'N/A',
        cost: data['cost'] ?? double.nan);
  }
}
