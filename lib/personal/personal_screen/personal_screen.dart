import 'package:first_ui/personal/personal_screen_view.dart/edit_profile.dart'
    show EditProfileScreen;
import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';
import 'package:first_ui/login/model/users.dart';

class PersonalScreen extends StatefulWidget {
  final String username;

  const PersonalScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Users? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final db = DatabaseHelper();
    Users? usr = await db.getUserByUsername(widget.username);
    setState(() {
      _user = usr;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang cá nhân"),
        backgroundColor: Colors.brown[400],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? const Center(child: Text("Không tìm thấy thông tin người dùng"))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/images/logo.png",
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _user!.fullname.isNotEmpty
                            ? _user!.fullname
                            : _user!.usrName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _user!.email.isNotEmpty
                            ? _user!.email
                            : "Chưa có email",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text("Chỉnh sửa thông tin cá nhân"),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditProfileScreen(username: widget.username),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock),
                        title: const Text("Đổi mật khẩu"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text("Cài đặt chung"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          "Đăng xuất",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}
