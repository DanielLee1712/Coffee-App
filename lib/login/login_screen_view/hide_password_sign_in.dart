import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style_packet/app_colors.dart';
import 'package:style_packet/app_text_styles.dart';
import '../provider/password_visibility_provider.dart';

class HidePassword extends StatelessWidget {
  final TextEditingController? controller;

  const HidePassword({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordVisibilityProvider>(
      builder: (context, visibilityProvider, _) {
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(225, 95, 27, .3),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              controller: controller,
              obscureText: visibilityProvider.isObscure,
              style: AppTextStyles.inputText,
              decoration: InputDecoration(
                hintText: "Mật khẩu",
                hintStyle: AppTextStyles.inputHint,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    visibilityProvider.isObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => visibilityProvider.toggleVisibility(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
