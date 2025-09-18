import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';
import 'package:first_ui/login/model/users.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _currentUsername;
  String? get currentUsername => _currentUsername;
  void setCurrentUsername(String? username) {
    _currentUsername = username;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    final usr = Users(
      usrName: username,
      password: password,
      fullname: '',
      email: '',
    );

    final dbHelper = DatabaseHelper();
    final success = await dbHelper.authenticate(usr);

    if (success) {
      _currentUsername = username;
    }

    _isLoading = false;
    notifyListeners();

    return success;
  }

  void logout() {
    _currentUsername = null;
    notifyListeners();
  }
}
