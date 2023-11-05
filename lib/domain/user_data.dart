class UserData {
  int userId;
  String name;
  String surname;
  String emailAddress;

  UserData(
      {required this.userId,
      required this.name,
      required this.surname,
      required this.emailAddress});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      emailAddress: json['emailAddress'] as String,
    );
  }
}
