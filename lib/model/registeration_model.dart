
import 'dart:convert';

RegisterationModel registerationModelFromJson(String str) => RegisterationModel.fromJson(json.decode(str));

String registerationModelToJson(RegisterationModel data) => json.encode(data.toJson());

String registerDetailToJson(RegisterationModel data) => json.encode(data.toJson());

class RegisterationModel {
  String username;
  List<UserAttribute> userAttributes;
  String password;

  RegisterationModel({
    required this.username,
    required this.userAttributes,
    required this.password,
  });

  factory RegisterationModel.fromJson(Map<String, dynamic> json) => RegisterationModel(
    username: json["username"],
    userAttributes: List<UserAttribute>.from(json["userAttributes"].map((x) => UserAttribute.fromJson(x))),
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "userAttributes": List<dynamic>.from(userAttributes.map((x) => x.toJson())),
    "password": password,
  };
}

class UserAttribute {
  String name;
  String value;

  UserAttribute({
    required this.name,
    required this.value,
  });

  factory UserAttribute.fromJson(Map<String, dynamic> json) => UserAttribute(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}
