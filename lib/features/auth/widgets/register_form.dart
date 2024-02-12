import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_watt/core/build_form_field.dart';

import 'auth_validation.dart';

const textDirection = TextDirection.ltr;

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.userEmailFocusNode,
    required this.onEmailSaved,
    required this.onUserNameSaved,
    required this.userNameFocusNode,
    required this.onPhoneNumberSaved,
    required this.phoneNumberFocusNode,
    required this.confirmPasswordFocusNode,
    required this.passwordFocusNode,
    required this.onPasswordSaved,
    required this.isPasswordHide,
    required this.onChangeVisibility,
    required this.isVisible,
    required this.passwordController,
  });

  final void Function(String?)? onUserNameSaved;
  final FocusNode? userNameFocusNode;

  final void Function(String?)? onEmailSaved;
  final FocusNode? userEmailFocusNode;

  final void Function(String?)? onPhoneNumberSaved;
  final FocusNode? phoneNumberFocusNode;

  final FocusNode? passwordFocusNode;
  final FocusNode? confirmPasswordFocusNode;
  final TextEditingController passwordController;
  final void Function(String?)? onPasswordSaved;
  final void Function()? onChangeVisibility;
  final bool isPasswordHide;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BuildFormField(
            textDirection: textDirection,
            fieldName: "Name",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            focusNode: userNameFocusNode,
            prefixIcon: const Icon(
              CupertinoIcons.person,
              color: Colors.grey,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(userEmailFocusNode);
            },
            validator: AuthValidation.userNameValidation,
            onSaved: onUserNameSaved,
          ),
          const SizedBox(height: 15),
          BuildFormField(
            textDirection: textDirection,
            fieldName: "Email",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            focusNode: userEmailFocusNode,
            prefixIcon: const Icon(
              CupertinoIcons.mail,
              color: Colors.grey,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(phoneNumberFocusNode);
            },
            validator: AuthValidation.emailValidation,
            onSaved: onEmailSaved,
          ),
          const SizedBox(height: 15),
          BuildFormField(
            textDirection: textDirection,
            fieldName: "Phone Number",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            focusNode: phoneNumberFocusNode,
            prefixIcon: const Icon(
              CupertinoIcons.device_phone_portrait,
              color: Colors.grey,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            validator: AuthValidation.userNameValidation,
            onSaved: onPhoneNumberSaved,
          ),
          const SizedBox(height: 15),
          BuildFormField(
            textDirection: textDirection,
            fieldName: "Password",
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isPasswordHide,
            textInputAction: TextInputAction.next,
            focusNode: passwordFocusNode,
            prefixIcon: const Icon(
              CupertinoIcons.lock,
              color: Colors.grey,
            ),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
            },
            style: Theme.of(context).textTheme.bodyMedium,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onChangeVisibility,
            ),
            validator: AuthValidation.passwordValidation,
            onSaved: onPasswordSaved,
          ),
          const SizedBox(height: 15),
          BuildFormField(
            textDirection: textDirection,
            fieldName: "Confirm Password",
            keyboardType: TextInputType.visiblePassword,
            obscureText: isPasswordHide,
            textInputAction: TextInputAction.done,
            focusNode: confirmPasswordFocusNode,
            prefixIcon: const Icon(
              CupertinoIcons.lock,
              color: Colors.grey,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onChangeVisibility,
            ),
            validator: (value) {
              return AuthValidation.confirmPasswordValidator(value, passwordController.text);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
