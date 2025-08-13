import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.read<HomeMainProvider>().toggleMenu();
          },
          child: Container(
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
