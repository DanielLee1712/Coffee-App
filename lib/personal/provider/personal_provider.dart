import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';
import 'package:first_ui/login/model/users.dart';

class PersonalProvider extends ChangeNotifier {
  Users? _user;
  bool _loading = true;

  Users? get user => _user;
  bool get loading => _loading;

  Future<void> loadUser(String username) async {
    _loading = true;
    notifyListeners();

    final db = DatabaseHelper();
    final usr = await db.getUserByUsername(username);

    _user = usr;
    _loading = false;
    notifyListeners();
  }

  Future<bool> changePassword(
      String username, String oldPassword, String newPassword) async {
    if (_user == null ||
        _user!.usrName != username ||
        _user!.password != oldPassword) {
      return false;
    }

    _loading = true;
    notifyListeners();

    final db = DatabaseHelper();
    _user = Users(
      usrId: _user!.usrId,
      usrName: _user!.usrName,
      password: newPassword,
      fullname: _user!.fullname,
      email: _user!.email,
    );
    await db.updateUser(_user!);

    _loading = false;
    notifyListeners();
    return true;
  }
}
