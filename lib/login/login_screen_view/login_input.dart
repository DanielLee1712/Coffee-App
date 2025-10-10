import 'package:flutter/material.dart';
import 'package:style_packet/app_text_styles.dart';
import 'hide_password_sign_in.dart';
import 'remember.dart';

class LoginInput extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginInput({
    Key? key,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Email hoặc Tên đăng nhập",
                hintStyle: AppTextStyles.inputHint,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        HidePassword(controller: passwordController),
        Remember(
          initialValue: false,
          onChanged: (value) => debugPrint("ghi nhớ đăng nhập: $value"),
        ),
      ],
    );
  }
}
