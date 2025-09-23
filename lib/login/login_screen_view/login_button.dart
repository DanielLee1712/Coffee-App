import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/login/provider/login_provider.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginButton({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) {
        return ElevatedButton(
          onPressed: loginProvider.isLoading
              ? null
              : () async {
                  final username = usernameController.text.trim();
                  final password = passwordController.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Vui lòng nhập đầy đủ thông tin"),
                      ),
                    );
                    return;
                  }

                  final success = await loginProvider.login(username, password);

                  if (!context.mounted) return;

                  if (success) {
                    context
                        .read<HomeMainProvider>()
                        .setSelectedBottomNavIndex(0);
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 18, 142, 243),
            padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.3),
          ),
          child: const Text(
            "Đăng nhập",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
