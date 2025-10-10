import 'package:flutter/material.dart';
import 'package:first_ui/login/model/users.dart';
import 'package:style_packet/app_text_styles.dart';

class PersonalAvatar extends StatelessWidget {
  final Users user;
  const PersonalAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("assets/images/logo.png"),
        ),
        const SizedBox(height: 15),
        Text(user.fullname.isNotEmpty ? user.fullname : user.usrName,
            style: AppTextStyles.pageTitle.s(22)),
        const SizedBox(height: 8),
        Text(user.email.isNotEmpty ? user.email : "Chưa có email",
            style: AppTextStyles.bodySecondary.s(16)),
      ],
    );
  }
}
