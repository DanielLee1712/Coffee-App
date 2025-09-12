import 'package:first_ui/login/provider/login_provider.dart';
import 'package:first_ui/login/login_screen_view/remember.dart';
import 'package:first_ui/sign%20up/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_ui/login/login_screen_view/hide_password_sign_in.dart';
import 'package:provider/provider.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
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
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom > 0
                              ? 20
                              : 50,
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
                            MediaQuery.of(context).viewInsets.bottom > 0
                                ? 10
                                : 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Coffee",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).viewInsets.bottom >
                                              0
                                          ? 35
                                          : 45,
                                  fontWeight: FontWeight.bold,
                                  shadows: const [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom > 0
                                        ? 15
                                        : 30,
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
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 5),
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
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: TextField(
                                          controller: _usernameController,
                                          decoration: const InputDecoration(
                                            hintText:
                                                "Email hoặc Tên đăng nhập",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                HidePassword(
                                  controller: _passwordController,
                                ),
                                Remember(
                                  initialValue: false,
                                  onChanged: (value) {
                                    debugPrint("ghi nhớ đăng nhập: $value");
                                  },
                                ),
                                const SizedBox(height: 20),
                                Consumer<LoginProvider>(
                                  builder: (context, loginProvider, _) {
                                    return ElevatedButton(
                                      onPressed: loginProvider.isLoading
                                          ? null
                                          : () async {
                                              final username =
                                                  _usernameController.text
                                                      .trim();
                                              final password =
                                                  _passwordController.text
                                                      .trim();

                                              if (username.isEmpty ||
                                                  password.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Vui lòng nhập đầy đủ thông tin"),
                                                  ),
                                                );
                                                return;
                                              }

                                              final success =
                                                  await loginProvider.login(
                                                      username, password);
                                              if (!context.mounted) return;

                                              if (success) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Đăng nhập thành công!"),
                                                  ),
                                                );
                                                Navigator.pushReplacementNamed(
                                                    context, '/home');
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Sai tài khoản hoặc mật khẩu"),
                                                  ),
                                                );
                                              }
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 18, 142, 243),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 110,
                                          vertical: 15,
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        elevation: 8,
                                        shadowColor:
                                            Colors.black.withOpacity(0.3),
                                      ),
                                      child: loginProvider.isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white)
                                          : const Text(
                                              "Đăng nhập",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 35),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom >
                                            0
                                        ? 10
                                        : 20,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    color: Colors.black54,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                  color: Colors.black54,
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUpScreen(),
                                                ),
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
                                                    color: Colors.black54,
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
