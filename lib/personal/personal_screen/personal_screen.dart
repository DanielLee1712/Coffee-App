import 'package:first_ui/login/provider/login_provider.dart';
import 'package:first_ui/personal/personal_screen_view.dart/edit_profile.dart'
    show EditProfileScreen;
import 'package:flutter/material.dart';
import 'package:first_ui/personal/provider/personal_provider.dart';
import 'package:provider/provider.dart';

class PersonalScreen extends StatefulWidget {
  final String username;

  const PersonalScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PersonalProvider>(context, listen: false)
          .loadUser(widget.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang cá nhân"),
        backgroundColor: Colors.brown[400],
      ),
      body: Consumer<PersonalProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.user == null) {
            return const Center(
                child: Text("Không tìm thấy thông tin người dùng"));
          }
          final user = provider.user!;
          return SingleChildScrollView(
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
                  user.fullname.isNotEmpty ? user.fullname : user.usrName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email.isNotEmpty ? user.email : "Chưa có email",
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
                    context.read<LoginProvider>().logout();

                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
