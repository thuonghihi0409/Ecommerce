class User {
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

  User({
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
  });}
