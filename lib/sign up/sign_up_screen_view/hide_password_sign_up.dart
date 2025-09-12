import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login/provider/password_visibility_provider.dart';
import '../provider/sign_up_provider.dart';

class HidePassword extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool Function(SignUpProvider) getError;

  const HidePassword({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.getError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordVisibilityProvider, SignUpProvider>(
      builder: (context, visibilityProvider, signUpProvider, _) {
        final error = signUpProvider.submitted && getError(signUpProvider);

        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(225, 95, 27, .3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: visibilityProvider.isObscure,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: error ? Colors.red : Colors.transparent, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: error ? Colors.red : Colors.blue, width: 2),
              ),
              suffixIcon: error
                  ? const Icon(Icons.error, color: Colors.red)
                  : IconButton(
                      icon: Icon(
                        visibilityProvider.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: visibilityProvider.toggleVisibility,
                    ),
            ),
            onChanged: (_) => signUpProvider.validateFields(),
          ),
        );
      },
    );
  }
}
