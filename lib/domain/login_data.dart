class LoginData {
  String username;
  String password;
  String roleName;

  LoginData({
    required this.username,
    required this.password,
    required this.roleName
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'roleName': roleName,
    };
  }
}