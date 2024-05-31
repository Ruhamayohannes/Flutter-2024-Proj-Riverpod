import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.fullName,
    required this.username,
    required this.password,
    required this.email,
  });

  String fullName;
  String username;
  String password;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["fullName"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "username": username,
        "password": password,
        "email": email,
      };
}
