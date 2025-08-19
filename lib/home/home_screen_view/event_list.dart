import 'package:flutter/material.dart';

class EventItem {
  final String img;
  final String desc;
  const EventItem({required this.img, required this.desc});
}

class EventsListHorizontal extends StatelessWidget {
  final List<EventItem> events;
  final ScrollPhysics? physics;
  final double spacing;
  final double? itemExtent;

  const EventsListHorizontal({
    Key? key,
    required this.events,
    this.physics,
    this.spacing = 10.0,
    this.itemExtent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics ?? const BouncingScrollPhysics(),
      itemCount: events.length +
          (spacing > 0 ? (events.isNotEmpty ? events.length - 1 : 0) : 0),
      itemExtent: itemExtent,
      itemBuilder: (context, i) {
        if (spacing > 0 && i.isOdd) {
          return SizedBox(height: spacing);
        }
        final idx = spacing > 0 ? (i ~/ 2) : i;
        final item = events[idx];
        return _EventTileHorizontal(item: item);
      },
    );
  }
}

class _EventTileHorizontal extends StatelessWidget {
  final EventItem item;
  const _EventTileHorizontal({Key? key, required this.item}) : super(key: key);

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
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.local_cafe),
              ),
            ),
          ),
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
