import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';
import 'package:first_ui/home/home_screen_view/product_grid.dart';
import 'package:first_ui/home/home_screen_view/event_list.dart';
import 'package:first_ui/cart/cart_screen/cart_screen_main.dart';
import 'package:first_ui/personal/personal_screen/personal_screen.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({Key? key}) : super(key: key);

  static const List<Widget> _screens = [
    Column(
      children: [
        Expanded(child: ProductGridSmall()),
        Expanded(child: EventsListVertical()),
      ],
    ),
    Center(child: Text('Yêu thích')),
    CartPage(),
    Center(child: Text('Thông báo')),
    PersonalScreen(username: "user"),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeMainProvider>(
      builder: (context, homeProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          body: _screens[homeProvider.selectedBottomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Trang chủ'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: 'Yêu thích'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: 'Giỏ hàng'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined), label: 'Thông báo'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Cá nhân'),
            ],
            currentIndex: homeProvider.selectedBottomNavIndex,
            selectedItemColor: Colors.brown,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              homeProvider.setSelectedBottomNavIndex(index);
            },
          ),
        );
      },
    );
  }
}
