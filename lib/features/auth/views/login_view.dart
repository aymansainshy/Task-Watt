import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_watt/core/constant.dart';
import 'package:task_watt/features/auth/controller/auth_controller.dart';
import 'package:task_watt/features/auth/views/register_view.dart';
import 'package:task_watt/features/map/views/main_map_view.dart';
import 'package:task_watt/utils/assets_helper.dart';

import '../widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authController = Get.find();

  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  var isVisible = false;
  var isPasswordHide = true;

  var logInData = {
    'email': '',
    'password': '',
  };

  void _saveForm() async {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formKey.currentState?.save();
    await _authController.login(logInData['email']!.trim(), logInData["password"]!.trim(), context);
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.onInverseSurface),
      body: GestureDetector(
        onTap: () {
          if (_focusScopeNode.hasFocus) {
            _focusScopeNode.unfocus();
          }
        },
        child: FocusScope(
          node: _focusScopeNode,
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mediaQuery.height * 0.20,
                        width: mediaQuery.width / 1.1,
                        child: Hero(
                          tag: "logoTage",
                          child: Image.asset(
                            AssetsUtils.appLogo,
                            fit: BoxFit.contain,
                            // colorFilter: const ColorFilter.mode(
                            //   Colors.red,
                            //   BlendMode.srcIn,
                            // ),
                            // semanticsLabel: 'A red up arrow',
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.10),
                      LoginForm(
                        isVisible: isVisible,
                        isPasswordHide: isPasswordHide,
                        passwordFocusNode: _passwordFocusNode,
                        emailFocusNode: _emailFocusNode,
                        onPasswordSaved: (value) {
                          logInData['password'] = value!;
                        },
                        onEmailSaved: (value) {
                          logInData['email'] = value!;
                        },
                        onChangeVisibility: () {
                          setState(() {
                            isVisible = !isVisible;
                            isPasswordHide = !isPasswordHide;
                          });
                        },
                      ),

                      GetX<AuthController>(
                        builder: (authController) {
                          switch (authController.loginState) {
                            case LoginState.inital:
                              return SizedBox(
                                width: mediaQuery.width,
                                height: kElevatedButtonHeight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                                    ),
                                    onPressed: () {
                                      _saveForm();
                                    },
                                    child: Text(
                                      "Login",
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            case LoginState.loading:
                              return SizedBox(
                                width: mediaQuery.width,
                                height: kElevatedButtonHeight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                                    ),
                                    onPressed: null,
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              );
                            default:
                              return Container();
                          }
                        },
                      ),

                      TextButton(
                        onPressed: () {
                          Get.off(const RegisterView());
                        },
                        child: const Text("Create a new account"),
                      ),
                      SizedBox(height: mediaQuery.height / 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
