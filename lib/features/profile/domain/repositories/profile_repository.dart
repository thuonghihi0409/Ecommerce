import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(String email);
}
