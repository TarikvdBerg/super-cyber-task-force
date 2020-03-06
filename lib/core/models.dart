import 'dart:convert';

import 'package:SCTFPasswordManager/passwords/group.dart';

class UserModel {
  final String id;
  final String userName;
  final String eMail;
  final String firstName;
  final String lastName;
  final String displayName;

  UserModel(
      {this.id,
      this.userName,
      this.eMail,
      this.firstName,
      this.lastName,
      this.displayName});

  Map<String, String> toJSON() {
    return {
      "id": this.id,
      "username": this.userName,
      "email": this.eMail,
      "first_name": this.firstName,
      "last_name": this.lastName,
      "display_name": this.displayName,
    };
  }

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        userName: json['username'],
        eMail: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        displayName: json['display_name']);
  }

  @override
  String toString() {
    return "User $userName with ID: $id";
  }
}

class PasswordGroupModel {
  final String id;
  final String name;

  PasswordGroupModel({this.id, this.name});

  Map<String, String> toJSON() {
    return {
      "id": this.id,
      "enc_name": this.name
    };
  }

  factory PasswordGroupModel.fromJSON(Map<String, dynamic> json) {
    return PasswordGroupModel(
      id: json["id"],
      name: json["enc_name"]
    );
  }

  @override
  String toString() {
    return "Password Group: $name";
  }
}

List<PasswordGroupModel> parsePasswordGroups(String body) {
  final parsed = json.decode(body).cast<Map<String, dynamic>>();
  return parsed
      .map<PasswordGroupModel>((json) => PasswordGroupModel.fromJSON(json))
      .toList();
}

class PasswordModel {
  final String id;
  final String encName;
  final String encDescription;
  final String encPassword;
  final String group;

  PasswordModel(
      {this.id,
      this.encName,
      this.encDescription,
      this.encPassword,
      this.group});

  Map<String, String> toJSON() {
    return {
      "id": this.id,
      "enc_name": this.encName,
      "enc_description": this.encDescription,
      "enc_password": this.encPassword,
      "parent_group": this.group
    };
  }

  factory PasswordModel.fromJSON(Map<String, dynamic> json) {
    return PasswordModel(
      id: json["id"],
      encName: json["enc_name"],
      encDescription: json["enc_description"],
      encPassword: json["enc_password"],
      group: json["parent_group"],
    );
  }

  @override
  String toString() {
    return "Password: $encName";
  }
}

List<PasswordModel> parsePasswords(String body) {
  final parsed = json.decode(body).cast<Map<String, dynamic>>();
  return parsed
      .map<PasswordModel>((json) => PasswordModel.fromJSON(json))
      .toList();
}