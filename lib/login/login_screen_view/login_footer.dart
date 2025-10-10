import 'package:flutter/material.dart';
import 'package:first_ui/sign%20up/sign_up_screen/sign_up_screen.dart';
import 'package:style_packet/app_text_styles.dart';

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
                  style: AppTextStyles.link,
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Column(
            children: <Widget>[
              Text(
                "Bạn chưa có tài khoản?",
                style: AppTextStyles.bodySecondary.c(Colors.white),
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
                  style: AppTextStyles.link,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
