import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';

abstract class AuthRemoteDataSource {
  Future<User?> login(String email, String password);
  Future<void> logout();
  Future<User?> register(String email, String password);
  Future<void> sendVerifyEmail(String email);
  Future<void> createUser({String? id, String? name, String? email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<User?> login(String email, String password) async {
    final user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return user.user;
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<User?> register(String email, String password) async {
    final user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  @override
  Future<void> sendVerifyEmail(String email) async {
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
  }

  @override
  Future<void> createUser({String? id, String? name, String? email}) async {
    log("on createuser");
    await supabase.from("Users").insert({
      'name': name,
      'email': email,
      'role': "is_custommer",
    });
  }
}
