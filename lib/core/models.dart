import 'dart:convert';

class AuthTokenModel {
  final String id;
  final String authenticationToken;
  final DateTime expiryDate;
  final DateTime validUntil;

  AuthTokenModel({this.id, this.authenticationToken, this.expiryDate, this.validUntil});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "token": this.authenticationToken,
      "expiry_date": this.expiryDate,
      "valid_until": this.validUntil
    };
  }

  factory AuthTokenModel.fromMap(Map<String, dynamic> map) {
    return AuthTokenModel(
      id: map["id"],
      authenticationToken: map["token"],
      expiryDate: map["expiry_date"],
      validUntil: map["valid_until"]
    );
  }
}

class UserModel {
  final String id;
  final String userName;
  final String eMail;
  final String firstName;
  final String lastName;
  final String displayName;
  final DateTime validUntil;

  UserModel(
      {this.id,
      this.userName,
      this.eMail,
      this.firstName,
      this.lastName,
      this.displayName,
      this.validUntil});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "username": this.userName,
      "email": this.eMail,
      "first_name": this.firstName,
      "last_name": this.lastName,
      "display_name": this.displayName,
      "valid_until": this.validUntil,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        userName: map['username'],
        eMail: map['email'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        displayName: map['display_name'],
        validUntil: map["'valid_until"]);
  }

  @override
  String toString() {
    return "User $userName with ID: $id";
  }
}

class PasswordGroupModel {
  final String id;
  final String name;
  final DateTime validUntil;

  PasswordGroupModel({this.id, this.name, this.validUntil});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "enc_name": this.name,
      "valid_until": this.validUntil,
    };
  }

  factory PasswordGroupModel.fromMap(Map<String, dynamic> map) {
    return PasswordGroupModel(
      id: map["id"],
      name: map["enc_name"],
      validUntil: map["valid_until"]
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
      .map<PasswordGroupModel>((json) => PasswordGroupModel.fromMap(json))
      .toList();
}

class PasswordModel {
  final String id;
  final String encName;
  final String encDescription;
  final String encPassword;
  final String group;
  final DateTime validUntil;

  PasswordModel(
      {this.id,
      this.encName,
      this.encDescription,
      this.encPassword,
      this.group,
      this.validUntil});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "enc_name": this.encName,
      "enc_description": this.encDescription,
      "enc_password": this.encPassword,
      "parent_group": this.group,
      "valid_unitl": this.validUntil,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      id: map["id"],
      encName: map["enc_name"],
      encDescription: map["enc_description"],
      encPassword: map["enc_password"],
      group: map["parent_group"],
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
      .map<PasswordModel>((json) => PasswordModel.fromMap(json))
      .toList();
}