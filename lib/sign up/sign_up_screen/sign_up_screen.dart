import 'package:first_ui/sign%20up/sign_up_screen_view/hide_password_sign_up.dart';
import 'package:first_ui/sign%20up/provider/sign_up_provider.dart';
import 'package:first_ui/login/provider/password_visibility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            _buildBackground(),
            SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                child: Consumer<SignUpProvider>(
                  builder: (context, signUpProvider, _) {
                    return Column(
                      children: [
                        const SizedBox(height: 50),
                        Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Tạo tài khoản",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildField(
                          label: "Tên đăng nhập",
                          icon: Icons.person,
                          controller: signUpProvider.usernameController,
                          error: signUpProvider.submitted &&
                              signUpProvider.usernameError,
                          onChanged: () => signUpProvider.validateFields(),
                        ),
                        const SizedBox(height: 20),
                        _buildField(
                          label: "Email",
                          icon: Icons.email,
                          controller: signUpProvider.emailController,
                          error: signUpProvider.submitted &&
                              signUpProvider.emailError,
                          onChanged: () => signUpProvider.validateFields(),
                        ),
                        const SizedBox(height: 20),
                        ChangeNotifierProvider(
                          create: (_) => PasswordVisibilityProvider(),
                          child: HidePassword(
                            controller: signUpProvider.passwordController,
                            hintText: "Mật khẩu",
                            getError: (p) => p.passwordError,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ChangeNotifierProvider(
                          create: (_) => PasswordVisibilityProvider(),
                          child: HidePassword(
                            controller:
                                signUpProvider.confirmPasswordController,
                            hintText: "Xác nhận mật khẩu",
                            getError: (p) => p.confirmPasswordError,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (signUpProvider.isValid()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Đăng ký thành công!")),
                              );
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 18, 142, 243),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110, vertical: 15),
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            elevation: 8,
                            shadowColor: Colors.black.withOpacity(0.3),
                          ),
                          child: const Text("Đăng ký",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Bạn đã có tài khoản?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool error,
    required VoidCallback onChanged,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: error ? Colors.red : Colors.transparent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: error ? Colors.red : Colors.blue, width: 2),
        ),
        suffixIcon: error ? const Icon(Icons.error, color: Colors.red) : null,
      ),
      onChanged: (_) => onChanged(),
    );
  }
}
