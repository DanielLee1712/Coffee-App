import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/home/provider/home_config_provider.dart';
import 'package:style_packet/app_text_styles.dart';

class EventsListVertical extends StatelessWidget {
  const EventsListVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeConfigProvider>(context);

    switch (provider.status) {
      case HomeConfigStatus.loading:
        return const SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          ),
        );

      case HomeConfigStatus.error:
        return const SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Có lỗi xảy ra khi tải dữ liệu sự kiện",
                style: AppTextStyles.error,
              ),
            ),
          ),
        );

      case HomeConfigStatus.loaded:
        final events = provider.events;
        if (events.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Không có sự kiện nào",
                  style: AppTextStyles.bodySecondary,
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: Image.asset(
                        event.img,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          event.desc,
                          style: AppTextStyles.bodyStrong,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: events.length,
          ),
        );
    }
  }
}
