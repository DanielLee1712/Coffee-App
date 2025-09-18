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
}
