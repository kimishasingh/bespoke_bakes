class UserData {
  int userId;
  String name;
  String surname;

  UserData({required this.userId, required this.name, required this.surname});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
    );
  }
}
