import 'package:first_ui/personal/personal_screen_view.dart/personal_actions.dart';
import 'package:first_ui/personal/personal_screen_view.dart/personal_avatar.dart';
import 'package:first_ui/personal/provider/personal_provider.dart';
import 'package:flutter/material.dart';
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
      context.read<PersonalProvider>().loadUser(widget.username);
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
                PersonalAvatar(user: user),
                const SizedBox(height: 30),
                const Divider(),
                PersonalActions(username: widget.username),
              ],
            ),
          );
        },
      ),
    );
  }
}
