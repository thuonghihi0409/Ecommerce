class ProfileEntity {
  final String id;
  final String name;

  final String? phone;
  final String? email;
  final String? role;
  final DateTime? birth;
  final String? gender;

  final String? image;

  ProfileEntity({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    required this.role,
    this.birth,
    this.gender,
    this.image,
  });
}
