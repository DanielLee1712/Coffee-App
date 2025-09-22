import 'package:flutter/material.dart';
import 'package:first_ui/sign%20up/sign_up_screen/sign_up_screen.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 10 : 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Quên mật khẩu?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    shadows: [
                      Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black54),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Column(
            children: <Widget>[
              const Text(
                "Bạn chưa có tài khoản?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  shadows: [
                    Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black54),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black54),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
