import '../models/conversation_model.dart';

import 'package:dio/dio.dart';


abstract class ChatRemoteDataSource {
  Future<ConversationModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<ConversationModel> login(String email, String password) async {
    final response = await dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return ConversationModel.fromJson(response.data);
    } else {
      throw Exception('Login failed');
    }
  }
}
