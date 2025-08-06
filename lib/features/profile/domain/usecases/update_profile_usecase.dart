import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;

  UpdateProfileUsecase(this.repository);
  Future<void> call({required ProfileEntity profile}) async {
    repository.updateProfile(profile);
  }
}
