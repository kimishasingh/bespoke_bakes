class LocationData {
  int id;
  String name;

  LocationData({required this.id, required this.name});

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(id: json['id'] as int, name: json['name'] as String);
  }
}
