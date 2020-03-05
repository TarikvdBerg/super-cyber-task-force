
class UserModel {
  final String userName;
  final String eMail;
  final String firstName;
  final String lastName;
  final String displayName;

  UserModel({this.userName, this.eMail, this.firstName, this.lastName, this.displayName});

  Map<String, String> toJSON() {
    return {
      "username": this.userName,
      "email": this.eMail,
      "first_name": this.firstName,
      "last_name": this.lastName,
      "display_name": this.displayName,
    };
  }

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      userName: json['user_name'],
      eMail: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      displayName: json['display_name']
    );
  }
}