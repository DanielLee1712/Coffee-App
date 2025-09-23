import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';
import 'package:first_ui/login/model/users.dart';

class EditProfileProvider with ChangeNotifier {
  final _db = DatabaseHelper();

  bool loading = false;
  Users? user;
  String? errorMessage;

  Future<void> loadUser(String username) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      user = await _db.getUserByUsername(username);
    } catch (e) {
      errorMessage = "Không thể tải thông tin người dùng";
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> saveProfile({
    required String username,
    required String fullname,
    required String email,
  }) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final currentUser = await _db.getUserByUsername(username);
      if (currentUser == null) {
        errorMessage = "Không tìm thấy người dùng";
        loading = false;
        notifyListeners();
        return false;
      }

      final updatedUser = Users(
        usrId: currentUser.usrId,
        fullname: fullname,
        email: email,
        usrName: currentUser.usrName,
        password: currentUser.password,
      );

      await _db.updateUser(updatedUser);

      user = updatedUser;

      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = "Cập nhật thất bại";
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
