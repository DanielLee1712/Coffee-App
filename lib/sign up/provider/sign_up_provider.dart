import 'package:first_ui/database/database_helper.dart';
import 'package:first_ui/login/model/users.dart';
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

  Future<bool> register() async {
    if (!isValid()) return false;

    final user = Users(
      usrName: usernameController.text.trim(),
      email: emailController.text.trim(),
      fullname: "",
      password: passwordController.text.trim(),
    );

    try {
      final dbHelper = DatabaseHelper();
      await dbHelper.createUser(user);
      return true;
    } catch (e) {
      debugPrint("Error when creating user: $e");
      return false;
    }
  }
}
