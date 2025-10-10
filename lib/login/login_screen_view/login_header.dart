import 'package:flutter/material.dart';
import 'package:style_packet/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom > 0 ? 20 : 50,
        ),
        Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.coffee,
                size: 60,
                color: Colors.white,
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).viewInsets.bottom > 0 ? 10 : 20,
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Coffee",
                style: MediaQuery.of(context).viewInsets.bottom > 0
                    ? AppTextStyles.loginBrandCompact
                    : AppTextStyles.loginBrand,
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom > 0 ? 15 : 30,
              ),
              const Text(
                "Đăng nhập vào tài khoản của bạn",
                style: AppTextStyles.loginSubtitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
