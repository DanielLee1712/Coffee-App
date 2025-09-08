import 'package:first_ui/home/home_screen_view/event_list.dart';
import 'package:first_ui/home/home_screen_view/menu_screen.dart';
import 'package:first_ui/home/home_screen_view/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_ui/home/provider/home_main_provider.dart';
import 'package:first_ui/home/provider/home_config_provider.dart';
import 'package:first_ui/home/home_screen_view/home_header.dart';
import 'package:first_ui/home/home_screen_view/home_bottom_navigation_bar.dart';

const int kSectionProductGrid = 1;
const int kSectionEventTitle = 2;
const int kSectionEventList = 3;

class _SectionSliver {
  final int id;
  final Widget Function(BuildContext) buildSliver;
  const _SectionSliver({required this.id, required this.buildSliver});
}

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeConfigProvider>(context, listen: false).loadConfig();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeMainProvider>();

    final eventTitleText = "Sự kiện đang diễn ra";

    final sections = <_SectionSliver>[
      _SectionSliver(
        id: kSectionProductGrid,
        buildSliver: (ctx) => const ProductGridSmall(),
      ),
      _SectionSliver(
        id: kSectionEventTitle,
        buildSliver: (ctx) => SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 10),
            child: Text(
              eventTitleText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5D4037),
              ),
            ),
          ),
        ),
      ),
      _SectionSliver(
        id: kSectionEventList,
        buildSliver: (ctx) => const EventsListVertical(),
      ),
    ];

    sections.sort((a, b) => a.id.compareTo(b.id));
    final sortedSlivers = sections.map((s) => s.buildSliver(context)).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  ...sortedSlivers,
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
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Tiện ích',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: Divider(height: 1)),
                      SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          ListTile(
                            leading: const Icon(Icons.local_cafe),
                            title: const Text('Thực đơn'),
                            onTap: () {
                              context.read<HomeMainProvider>().closeMenu();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const MenuScreen(),
                                ),
                              );
                            },
                          ),
                          const ListTile(
                            leading: Icon(Icons.card_giftcard),
                            title: Text('Khuyến mãi'),
                          ),
                        ]),
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
  }
}
