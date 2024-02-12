import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_watt/core/build_form_field.dart';

import 'auth_validation.dart';

const textDirection = TextDirection.ltr;

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.onChangeVisibility,
    required this.isPasswordHide,
    required this.isVisible,
  });

  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;

  final FocusNode? emailFocusNode;
  final FocusNode? passwordFocusNode;

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
            fieldName: "Email",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            focusNode: emailFocusNode,
            prefixIcon: const Icon(
              CupertinoIcons.mail,
              color: Colors.grey,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            validator: AuthValidation.emailValidation,
            onSaved: onEmailSaved,
          ),
          const SizedBox(height: 15),
          BuildFormField(
            textDirection: textDirection,
            fieldName: "Password",
            keyboardType: TextInputType.visiblePassword,
            obscureText: isPasswordHide,
            textInputAction: TextInputAction.done,
            focusNode: passwordFocusNode,
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
            validator: AuthValidation.passwordValidation,
            onSaved: onPasswordSaved,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
