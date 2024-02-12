import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_watt/features/auth/models/user_model.dart';
import 'package:task_watt/features/map/views/main_map_view.dart';

import '../repositories/auth_ repository.dart';

enum LoginState { inital, loading, success, failure }

class UserResponse {
  User? user;
  String? error;

  UserResponse({User? user, String? error});
}

class AuthController extends GetxController {
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  final Rx<LoginState> _loginState = LoginState.inital.obs;

  final Rx<UserResponse> _userResponse = UserResponse().obs;

  LoginState get loginState => _loginState.value;

  UserResponse get userResponse => _userResponse.value;

  Future<void> login(String email, String password, BuildContext context) async {
    _loginState(LoginState.loading);
    final authResponse = await authRepository.login(email, password);

    if (authResponse is AuthResponseSuccess) {
      _userResponse.value.user = authResponse.user;
      _loginState(LoginState.success);
      Get.off(const MainMapView());
    } else if (authResponse is AuthResponseFailure) {
      _userResponse.value.error = authResponse.exception;
      _loginState(LoginState.failure);
      Get.snackbar('Error', authResponse.exception.toString());
      _loginState(LoginState.inital);
    }
  }
}
