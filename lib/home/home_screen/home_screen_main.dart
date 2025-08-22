import 'package:first_ui/home/home_screen_view/event_list.dart';
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
            desc: 'Mua 1 tặng 1 Cappuccino vào thứ 6.'),
        EventItem(
            img: 'assets/images/Iced_Americano.jpeg',
            desc: 'Ưu đãi thành viên mới đến 50%.'),
      ];

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
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Column(
                          children: [
                            HomeHeader(),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const ProductGridSmall(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 10),
                          child: Text(
                            'Sự kiện đang diễn ra',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.brown[700],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      EventsListHorizontal(events: events),
                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    ],
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
                              ),
                            ),
                          ),
                          const Divider(height: 1),
                          Expanded(
                            child: ListView(
                              children: const [
                                ListTile(
                                  leading: Icon(Icons.local_cafe),
                                  title: Text('Thực đơn'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.card_giftcard),
                                  title: Text('Khuyến mãi'),
                                ),
                              ],
                            ),
                          ),
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
