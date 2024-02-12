import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_watt/core/constant.dart';
import 'package:task_watt/features/auth/views/login_view.dart';
import 'package:task_watt/utils/assets_helper.dart';

import '../widgets/register_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  final _userNameFocusNode = FocusNode();
  final _userEmailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _passwordController = TextEditingController();

  var isVisible = false;
  var isPasswordHide = true;

  var registerData = {
    'name': '',
    'email': '',
    'phone': '',
    'password': '',
    'password_confirmation': '',
  };

  void _saveForm() async {
    final isValid = _formKey.currentState?.validate();

    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    registerData['password_confirmation'] = registerData['password']!;
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _passwordController.dispose();
    _userEmailFocusNode.dispose();
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
                          ),
                        ),
                      ),
                      // SizedBox(height: mediaQuery.height * 0.01),
                      // Hero(
                      //   tag: "topText",
                      //   child: Text(
                      //     "Register",
                      //     style: Theme.of(context).textTheme.titleLarge,
                      //   ),
                      // ),
                      SizedBox(height: mediaQuery.height * 0.05),
                      RegisterForm(
                        passwordController: _passwordController,
                        confirmPasswordFocusNode: _confirmPasswordFocusNode,
                        onUserNameSaved: (value) {
                          registerData['name'] = value!;
                        },
                        onEmailSaved: (value) {
                          registerData['email'] = value!;
                        },
                        onPhoneNumberSaved: (value) {
                          registerData['phone'] = value!;
                        },
                        onPasswordSaved: (value) {
                          registerData['password'] = value!;
                        },
                        userEmailFocusNode: _userEmailFocusNode,
                        userNameFocusNode: _userNameFocusNode,
                        isVisible: isVisible,
                        isPasswordHide: isPasswordHide,
                        passwordFocusNode: _passwordFocusNode,
                        phoneNumberFocusNode: _phoneNumberFocusNode,
                        onChangeVisibility: () {
                          setState(() {
                            isVisible = !isVisible;
                            isPasswordHide = !isPasswordHide;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
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
                              "Register",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(const LoginView());
                        },
                        child: const Text("I have account Login"),
                      ),
                      const SizedBox(height: 10),
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
