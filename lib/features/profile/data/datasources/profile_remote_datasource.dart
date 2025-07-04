import 'package:thuongmaidientu/features/profile/data/models/profile_model.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileEntityModel> getProfile(String email);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDatasource {
  @override
  Future<ProfileEntityModel> getProfile(String email) async {
    final profile =
        await supabase.from("Users").select().eq("email", email).single();

    return ProfileEntityModel.fromJson(profile);
  }
}
