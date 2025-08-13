import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/password_visibility_provider.dart';

class HidePassword extends StatefulWidget {
  const HidePassword({Key? key}) : super(key: key);

  @override
  State<HidePassword> createState() => _HidePasswordState();
}

class _HidePasswordState extends State<HidePassword> {
  @override
  Widget build(BuildContext context) {
    final visibilityProvider = Provider.of<PasswordVisibilityProvider>(context);
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(225, 95, 27, .3),
                blurRadius: 20,
                offset: Offset(0, 10))
          ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              obscureText: visibilityProvider.isObscure,
              decoration: InputDecoration(
                  hintText: "Mật khẩu",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      icon: Icon(visibilityProvider.isObscure
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        visibilityProvider.toggleVisibility();
                      })),
            ),
          ),
        ],
      ),
    );
  }
}
