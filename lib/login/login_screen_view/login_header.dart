import 'package:flutter/material.dart';

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
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      MediaQuery.of(context).viewInsets.bottom > 0 ? 35 : 45,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black54),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom > 0 ? 15 : 30,
              ),
              const Text(
                "Đăng nhập vào tài khoản của bạn",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black54),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
