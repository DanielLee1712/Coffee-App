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
            child: const Icon(
              Icons.grid_view,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<HomeMainProvider>().setSelectedBottomNavIndex(4);
          },
          child: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/logo.png"),
          ),
        ),
      ],
    );
  }
}
