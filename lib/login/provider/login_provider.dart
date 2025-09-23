import 'dart:async';
import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';
import 'package:first_ui/login/model/users.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _currentUsername;
  String? get currentUsername => _currentUsername;

  void setCurrentUsername(String? username) {
    _currentUsername = username;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      _errorMessage = "Vui lòng nhập đầy đủ thông tin";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final usr = Users(
      usrName: username,
      password: password,
      fullname: '',
      email: '',
    );

    try {
      final dbHelper = DatabaseHelper();
      final success = await dbHelper.authenticate(usr).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException("Kết nối cơ sở dữ liệu quá hạn");
        },
      );

      if (success) {
        _currentUsername = username;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Sai tài khoản hoặc mật khẩu";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } on TimeoutException {
      _errorMessage = "Không thể kết nối tới cơ sở dữ liệu.\nVui lòng thử lại.";
    } catch (e) {
      _errorMessage = "Đã xảy ra lỗi: $e";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _currentUsername = null;
    notifyListeners();
  }

  void resetError() {
    _errorMessage = null;
    notifyListeners();
  }
}
