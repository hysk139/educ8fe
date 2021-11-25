import 'dart:ui';

class Users{
  int? user_id;
  String? name;
  String? email;
  String? password;
  String? phone_number;


  Users(
      {
        this.name,
        this.email,
        this.user_id,
        this.password,
        this.phone_number
      }
      );

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        name: json['name'],
        email: json['email'],
        user_id: json['user_id'],
        password : json['password'],
        phone_number : json['phone_number'],
    );
  }
}