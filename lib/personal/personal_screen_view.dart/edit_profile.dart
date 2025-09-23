import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/personal/provider/edit_profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String username;

  const EditProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<EditProfileProvider>().loadUser(widget.username);
    });
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (context, provider, _) {
        if (provider.loading && provider.user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = provider.user;
        if (user != null) {
          _fullnameController.text = user.fullname;
          _emailController.text = user.email;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Chỉnh sửa thông tin"),
            backgroundColor: Colors.brown,
          ),
          body: Padding(
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.loading
                        ? null
                        : () async {
                            final success = await provider.saveProfile(
                              username: widget.username,
                              fullname: _fullnameController.text.trim(),
                              email: _emailController.text.trim(),
                            );
                            if (!mounted) return;
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Cập nhật thông tin thành công!"),
                                ),
                              );
                              Navigator.pop(context, true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(provider.errorMessage ??
                                      "Cập nhật thất bại"),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: provider.loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Lưu thay đổi",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
