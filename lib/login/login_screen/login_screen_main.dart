import 'package:flutter/material.dart';
import 'package:first_ui/login/login_screen_view/login_header.dart';
import 'package:first_ui/login/login_screen_view/login_input.dart';
import 'package:first_ui/login/login_screen_view/login_button.dart';
import 'package:first_ui/login/login_screen_view/login_footer.dart';

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
    return Scaffold(
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
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      const LoginHeader(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            children: <Widget>[
                              LoginInput(
                                usernameController: _usernameController,
                                passwordController: _passwordController,
                              ),
                              const SizedBox(height: 20),
                              LoginButton(
                                usernameController: _usernameController,
                                passwordController: _passwordController,
                              ),
                              const SizedBox(height: 35),
                              const LoginFooter(),
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
    );
  }
}
