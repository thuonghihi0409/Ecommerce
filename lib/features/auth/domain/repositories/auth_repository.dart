import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<UserEntity> register(String email, String password, String name);
  Future<void> sendVerifyEmail(String email);
}
