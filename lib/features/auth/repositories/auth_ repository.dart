import 'package:task_watt/core/api/network_result.dart';
import 'package:task_watt/core/api/network_services.dart';

import '../models/user_model.dart';

class AuthResponse {}

class AuthResponseSuccess extends AuthResponse {
  final User? user;

  AuthResponseSuccess({this.user});
}

class AuthResponseFailure extends AuthResponse {
  final String? exception;

  AuthResponseFailure(this.exception);
}

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);

  Future<AuthResponse> register(Map<String, dynamic> registrationData);

  Future<AuthResponse> logOut();
}

class AuthRepositoryImpl extends AuthRepository {
  final NetworkServices networkServices;

  AuthRepositoryImpl(this.networkServices);

  final Map<String, dynamic> _users = {
    "ayman@gmail.com": User(
      id: DateTime.now().toIso8601String(),
      name: "Ayman Abdulrahman",
      email: "ayman@gmail.com",
      password: "Password123",
      accessToken: "access_token",
    )
  };

  @override
  Future<AuthResponse> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 3000));

    late AuthResponse authResponse;

    if (_users.containsKey(email)) {
      final User foundedUser = _users[email];
      if (foundedUser.password == password) {
        authResponse = AuthResponseSuccess(user: foundedUser);
      } else {
        authResponse = AuthResponseFailure("Wrong password !");
      }
    } else {
      authResponse = AuthResponseFailure("Account not found");
    }

    return authResponse;
  }

  @override
  Future<AuthResponse> register(Map<String, dynamic> registrationData) async {
    return await loginOrRegister("URL", registrationData);
  }

  @override
  Future<AuthResponse> logOut() async {
    final networkResult = await networkServices.post("URL");

    late AuthResponse authResponse;

    if (networkResult is NetworkResultSuccess) {
      authResponse = AuthResponseSuccess();
    }

    if (networkResult is NetworkResultFailure) {
      authResponse = AuthResponseFailure(networkResult.error.toString());
    }

    return authResponse;
  }

  Future<AuthResponse> loginOrRegister(String url, dynamic data) async {
    final networkResult = await networkServices.post(url, data: data);

    late AuthResponse authResponse;

    if (networkResult is NetworkResultSuccess) {
      final user = User.fromJson(networkResult.data["data"]);
      authResponse = AuthResponseSuccess(user: user);
    }

    if (networkResult is NetworkResultFailure) {
      authResponse = AuthResponseFailure(networkResult.error.toString());
    }

    return authResponse;
  }
}
