import 'package:flutter/material.dart';

class EventItem {
  final String img;
  final String desc;
  const EventItem({required this.img, required this.desc});

  factory EventItem.fromJson(Map<String, dynamic> j) =>
      EventItem(img: j['img'] as String, desc: (j['desc'] as String?) ?? '');

  Map<String, dynamic> toJson() => {'img': img, 'desc': desc};
}

class EventsListHorizontal extends StatelessWidget {
  final List<EventItem> events;
  final double spacing;
  final double? itemExtent;

  const EventsListHorizontal({
    Key? key,
    required this.events,
    this.spacing = 10.0,
    this.itemExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasSpacing = spacing > 0;
    final itemCount = events.length +
        (hasSpacing ? (events.isNotEmpty ? events.length - 1 : 0) : 0);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = hasSpacing ? index ~/ 2 : index;
          if (hasSpacing && index.isOdd) {
            return SizedBox(height: spacing);
          }
          final item = events[itemIndex];
          return _EventCard(item: item);
        },
        childCount: hasSpacing ? itemCount : events.length,
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventItem item;
  const _EventCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              item.img,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                item.desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13.5, height: 1.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
