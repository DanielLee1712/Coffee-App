import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool usernameError = false;
  bool emailError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;

  bool submitted = false;

  void validateFields() {
    if (!submitted) return;

    usernameError = usernameController.text.isEmpty;
    emailError = emailController.text.isEmpty;
    passwordError = passwordController.text.isEmpty;
    confirmPasswordError = confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text != passwordController.text;

    notifyListeners();
  }

  bool isValid() {
    submitted = true;
    validateFields();
    return !(usernameError ||
        emailError ||
        passwordError ||
        confirmPasswordError);
  }
}
