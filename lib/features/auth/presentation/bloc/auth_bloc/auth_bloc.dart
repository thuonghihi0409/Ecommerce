import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuongmaidientu/core/app_constraint.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/login_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/logout_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/register_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  LoginUseCase loginUseCase;
  LogoutUseCase logoutUseCase;
  RegisterUsecase registerUsecase;
  SendVerifyEmailUsecase sendVerifyEmailUsecase;
  AuthBloc(this.loginUseCase, this.registerUsecase, this.sendVerifyEmailUsecase,
      this.logoutUseCase)
      : super(AuthState.empty()) {
    on<AuthResumeSession>(authResumeSession);
    on<AuthLogin>(authLogin);
    on<AuthLogout>(authLogout);
    on<AuthRegister>(authRegister);
    on<AuthSendVerifyEmail>(authSendVerifyEmail);
  }

  String _firebaseAuthMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Email khong dung dinh dang';
      case 'user-not-found':
        return 'Khong tim thay tai khoan';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email hoặc mật khẩu không đúng';
      case 'email-already-in-use':
        return 'Email da duoc su dung';
      case 'weak-password':
        return 'Mat khau qua yeu';
      case 'user-disabled':
        return 'Tai khoan da bi vo hieu hoa';
      case 'too-many-requests':
        return 'Ban thao tac qua nhanh, vui long thu lai sau';
      case 'network-request-failed':
        return 'Loi ket noi mang, vui long kiem tra internet';
      case 'operation-not-allowed':
        return 'Phuong thuc dang nhap nay chua duoc bat tren Firebase';
      default:
        return e.message ?? 'Dang xay ra loi xac thuc';
    }
  }

  void authResumeSession(AuthResumeSession event, Emitter<AuthState> emit) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // get profile
        event.onSuccess.call(true, user.email);
      } else {
        event.onSuccess.call(false, user?.email);
      }
    } catch (e) {
      log("error 1 ==${ParseError.fromJson(e).message}");
      event.onError.call(ParseError.fromJson(e).message);
    }
  }

  void authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result =
          await loginUseCase.call(email: event.email, password: event.password);

      emit(state.copyWith(isLoading: false));
      log("is verify ==${result.isVerify}");
      if (!(result.isVerify ?? false)) {
        event.onSuccess?.call(AppConstraint.isNotVerify);
        return;
      }
      if (result.id != null) {
        event.onSuccess?.call(AppConstraint.login);
        return;
      }

      event.onSuccess?.call(AppConstraint.loginFailed);
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false));
      event.onError?.call(_firebaseAuthMessage(e));
    }
  }

  void authLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      await logoutUseCase.call();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('selected_store');
      emit(state.copyWith(isLoading: false));
      event.onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: _firebaseAuthMessage(e));
    }
  }

  void authRegister(AuthRegister event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(milliseconds: 1000));
      final result = await registerUsecase.call(
          email: event.email, password: event.password, name: event.name);
      emit(state.copyWith(isLoading: false));
      if (result.id != null) event.onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false));
      event.onError?.call(_firebaseAuthMessage(e));
    }
  }

  void authSendVerifyEmail(
      AuthSendVerifyEmail event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      log("before send");
      await sendVerifyEmailUsecase.call(email: event.email);
      log("affter send");
      emit(state.copyWith(isLoading: false));
      event.onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false));
      event.onError?.call(_firebaseAuthMessage(e));
    }
  }
}
