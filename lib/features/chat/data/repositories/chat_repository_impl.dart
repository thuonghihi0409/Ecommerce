import '../../domain/repositories/auth_repository.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements AuthRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);
}
