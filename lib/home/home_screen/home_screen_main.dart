import 'package:first_ui/home/home_screen_view/event_grid.dart';
import 'package:first_ui/home/home_screen_view/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_ui/home/provider/home_main_provider.dart';
import 'package:first_ui/home/home_screen_view/home_header.dart';
import 'package:first_ui/home/home_screen_view/home_bottom_navigation_bar.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  List<EventItem> _demoEvents() => const [
        EventItem(
            img: 'assets/images/Hot_Latte.jpeg',
            desc: 'Giảm 20% cho Latte vào thứ 4.'),
        EventItem(
            img: 'assets/images/Iced_Cappuccino.jpeg',
            desc: 'Combo Cappuccino + Bánh ngọt chỉ 29k.'),
        EventItem(
            img: 'assets/images/Iced_Espresso.jpeg',
            desc: 'Mua 2 tặng 1 — Espresso nguyên chất.'),
        EventItem(
            img: 'assets/images/logo.png',
            desc: 'Miễn phí giao hàng nội thành hôm nay.'),
        EventItem(
            img: 'assets/images/logo.png',
            desc: 'Ưu đãi thành viên mới đến 50%.'),
      ];

  double _eventsListHeight(int n,
      {double itemExtent = 90, double spacing = 10}) {
    if (n <= 0) return 0;
    return n * itemExtent + (n - 1) * spacing;
  }

  @override
  Widget build(BuildContext context) {
    final events = _demoEvents();

    return Consumer<HomeMainProvider>(
      builder: (context, homeProvider, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const Column(
                            children: [
                              HomeHeader(),
                              SizedBox(height: 20),
                            ],
                          );

                        case 1:
                          return const ProductGridSmall();

                        case 2:
                          return Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 10),
                            child: Text(
                              'Sự kiện đang diễn ra',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.brown[700],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );

                        case 3:
                          final h = _eventsListHeight(events.length);
                          return SizedBox(
                            height: h,
                            child: EventsListHorizontal(
                              events: events,
                            ),
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
              if (homeProvider.isMenuOpen) ...[
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => homeProvider.closeMenu(),
                    child: Container(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: homeProvider.isMenuOpen ? 0 : -300,
                  top: 0,
                  bottom: 0,
                  width: 300,
                  child: Material(
                    color: Colors.white,
                    elevation: 8,
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: const Text(
                              'Tiện ích',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB8860B),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ListTile(
                            leading: const Icon(Icons.menu,
                                color: Color(0xFFB8860B)),
                            title: const Text('Menu',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            onTap: () {
                              homeProvider.closeMenu();
                              Navigator.of(context).pushNamed('/menu');
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings,
                                color: Color(0xFFB8860B)),
                            title: const Text('Settings',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            onTap: () {
                              homeProvider.closeMenu();
                              // TODO: điều hướng settings nếu cần
                            },
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          bottomNavigationBar: const HomeBottomNavigationBar(),
        );
      },
    );
  }
}
