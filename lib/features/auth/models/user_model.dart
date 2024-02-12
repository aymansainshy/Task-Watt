import 'dart:convert';

String userToJson(User user) => json.encode(user.toJson());

class User {
  late String? id;
  late String? name;
  late String? email;
  late String? password;
  late String? location;
  late String? accessToken;
  late String? tokenType;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.location,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      accessToken: json["access_token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "access_token": accessToken,
      };
}
