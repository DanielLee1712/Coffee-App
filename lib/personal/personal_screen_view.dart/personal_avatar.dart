import 'package:flutter/material.dart';
import 'package:first_ui/login/model/users.dart';

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
        Text(
          user.fullname.isNotEmpty ? user.fullname : user.usrName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user.email.isNotEmpty ? user.email : "Chưa có email",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
