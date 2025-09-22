import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';
import 'package:first_ui/login/model/users.dart';

class EditProfileScreen extends StatefulWidget {
  final String username;

  const EditProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final db = DatabaseHelper();
    final user = await db.getUserByUsername(widget.username);
    if (user != null) {
      _fullnameController.text = user.fullname;
      _emailController.text = user.email;
      _usernameController.text = user.usrName;
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveProfile() async {
    final db = DatabaseHelper();
    final currentUser = await db.getUserByUsername(widget.username);
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không tìm thấy người dùng!")),
      );
      return;
    }
    final updatedUser = Users(
      usrId: currentUser.usrId,
      fullname: _fullnameController.text.trim(),
      email: _emailController.text.trim(),
      usrName: _usernameController.text.trim(),
      password: currentUser.password,
    );

    await DatabaseHelper.update(
        "users", updatedUser.toMap(), updatedUser.usrId ?? 0);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cập nhật thông tin thành công!")),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa thông tin"),
        backgroundColor: Colors.brown,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _fullnameController,
                    decoration: const InputDecoration(
                      labelText: "Họ và tên",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Lưu thay đổi",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
