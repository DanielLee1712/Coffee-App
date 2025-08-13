import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainProvider>(
      builder: (context, homeProvider, child) {
        return Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomNavItem(
                icon: Icons.home,
                index: 0,
                currentIndex: homeProvider.selectedBottomNavIndex,
                onTap: (index) {
                  homeProvider.setSelectedBottomNavIndex(index);
                },
              ),
              BottomNavItem(
                icon: Icons.favorite_border,
                index: 1,
                currentIndex: homeProvider.selectedBottomNavIndex,
                onTap: (index) {
                  homeProvider.setSelectedBottomNavIndex(index);
                },
              ),
              BottomNavItem(
                icon: Icons.shopping_bag_outlined,
                index: 2,
                currentIndex: homeProvider.selectedBottomNavIndex,
                onTap: (index) {
                  homeProvider.setSelectedBottomNavIndex(index);
                  Navigator.pushReplacementNamed(context, '/cart');
                },
              ),
              BottomNavItem(
                icon: Icons.notifications_outlined,
                index: 3,
                currentIndex: homeProvider.selectedBottomNavIndex,
                onTap: (index) {
                  homeProvider.setSelectedBottomNavIndex(index);
                },
              ),
              BottomNavItem(
                icon: Icons.person_outline,
                index: 4,
                currentIndex: homeProvider.selectedBottomNavIndex,
                onTap: (index) {
                  homeProvider.setSelectedBottomNavIndex(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB8860B) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[600],
          size: 24,
        ),
      ),
    );
  }
}
