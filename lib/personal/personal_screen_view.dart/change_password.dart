import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/personal/provider/personal_provider.dart';
import 'package:style_packet/app_text_styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String username;

  const ChangePasswordScreen({Key? key, required this.username})
      : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mật khẩu cũ",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mật khẩu mới",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Xác nhận mật khẩu mới",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            Consumer<PersonalProvider>(
              builder: (context, provider, _) {
                return ElevatedButton(
                  onPressed: provider.loading
                      ? null
                      : () async {
                          final oldPassword =
                              _oldPasswordController.text.trim();
                          final newPassword =
                              _newPasswordController.text.trim();
                          final confirmPassword =
                              _confirmPasswordController.text.trim();

                          if (newPassword != confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Mật khẩu xác nhận không khớp!")),
                            );
                            return;
                          }

                          final success = await provider.changePassword(
                            widget.username,
                            oldPassword,
                            newPassword,
                          );

                          if (!mounted) return;

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Đổi mật khẩu thành công!")),
                            );
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Mật khẩu cũ không đúng!")),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: provider.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Xác nhận", style: AppTextStyles.button.s(18)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
