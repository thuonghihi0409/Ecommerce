import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);
  Future<UserEntity> call(
      {required String email, required String password, required String name}) {
    return repository.register(email, password, name);
  }
}
