
class UserModel {
  late String? id;
  final String username;
  final String password;
  late String? phone;
  late String? email;
  final String role;
  late DateTime? birth;
  late String? gender;
  late String? fullname;
  late String? image;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    this.phone,
    this.email,
    required this.role,
    this.birth,
    this.gender,
    this.fullname,
    this.image,
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
