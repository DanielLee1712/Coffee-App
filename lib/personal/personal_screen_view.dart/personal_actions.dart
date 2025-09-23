import 'package:first_ui/login/provider/login_provider.dart';
import 'package:first_ui/personal/personal_screen_view.dart/change_password.dart';
import 'package:first_ui/personal/personal_screen_view.dart/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/personal/provider/personal_provider.dart';

class PersonalActions extends StatelessWidget {
  final String username;
  const PersonalActions({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Chỉnh sửa thông tin cá nhân"),
          onTap: () async {
            final updated = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditProfileScreen(username: username),
              ),
            );
            if (updated == true && context.mounted) {
              context.read<PersonalProvider>().loadUser(username);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text("Đổi mật khẩu"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChangePasswordScreen(username: username),
              ),
            );
          },
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
    );
  }
}
