import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFB8860B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.grid_view,
            color: Colors.white,
            size: 24,
          ),
        ),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.person,
            color: Colors.grey[600],
            size: 30,
          ),
        ),
      ],
    );
  }
}
