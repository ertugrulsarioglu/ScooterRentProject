import 'package:scooter_app/extensions/date_time_extension.dart';

class User {
  String? firstName;
  String? lastName;
  String? username;
  int? role;
  String? phoneNumber;
  String? email;
  String? address;
  String? password;
  DateTime? lastLogindDate;
  String? id;
  DateTime? createdDate;

  User(
      {this.firstName,
      this.lastName,
      this.username,
      this.role = 1,
      this.phoneNumber,
      this.email,
      this.address,
      this.password,
      this.id,
      this.lastLogindDate,
      this.createdDate});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    role = json['role'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
    lastLogindDate =
        DateTime.parse(json['lastLogindDate']).add(const Duration(hours: 3));
    id = json['id'];
    createdDate =
        DateTime.parse(json['createdDate']).add(const Duration(hours: 3));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['role'] = role;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['password'] = password;
    data['lastLogindDate'] = lastLogindDate?.toIso8601String();
    data['id'] = id;
    data['createdDate'] = createdDate?.toIso8601String();
    return data;
  }
}
