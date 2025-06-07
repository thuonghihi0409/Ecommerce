import '../../domain/entities/user.dart';

class UserModel extends User {
  
  UserModel({
    super.id,
    required super.username,
    required super.password,
    super.phone,
    super.email,
    required super.role,
    super.birth,
    super.gender,
    super.fullname,
    super.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'phone': phone,
      'email': email,
      'role': role,
      'birth': birth,
      'gender': gender,
      'fullname': fullname,
    };
  }


  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      birth: json['birth'] != '' ? DateTime.parse(json['birth']) : null,
      role: json['role'] ?? '',
      gender: json["gender"] ?? '',
      image: json["image"] ?? '',
    );
  }
}
