import '../../domain/entities/user.dart';

class UserMapper{

  static User userJsonToEntity( Map<String, dynamic> json) => User(
    email: json['email'],
    id: json['id'],
    userName: json['user'],
    fullName: json['fullName'],
    roles: List<String>.from(json['roles'].map((role)=> role)),
    token: json['token'],
    userType: json['userType'],
  );
}