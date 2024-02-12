import 'dart:developer';

class AuthValidation {
  static String? userNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    return null;
  }

  static String? emailValidation(String? value) {
    final RegExp isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value?.trim() == null || value!.isEmpty) {
      return "Email is required";
    }

    if (!value.contains("@")) {
      return "Inter a valid email";
    }
    if (!isEmailValid.hasMatch(value)) {
      return "Inter a valid email";
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    final RegExp passwordValid = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.toString().length < 6) {
      return "Password length must be at least 6 character";
    }
    if (!passwordValid.hasMatch(value)) {
      return "Must contain numbers, latter, Uppercase";
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value, String matchedValue) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != matchedValue) {
      return "Password not match";
    }
    return null;
  }
}
