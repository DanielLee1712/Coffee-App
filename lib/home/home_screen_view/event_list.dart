import 'package:flutter/material.dart';
import 'package:first_ui/home/home_screen_view/event_detail_screen.dart'; // <-- thêm import

class EventListRefreshBus extends ChangeNotifier {
  void trigger() => notifyListeners();
}

final eventListRefreshBus = EventListRefreshBus();

class EventItem {
  final String img;
  final String desc;
  const EventItem({required this.img, required this.desc});

  factory EventItem.fromJson(Map<String, dynamic> j) =>
      EventItem(img: j['img'] as String, desc: (j['desc'] as String?) ?? '');

  Map<String, dynamic> toJson() => {'img': img, 'desc': desc};
}

class EventsListHorizontal extends StatefulWidget {
  final List<EventItem> events;
  final double spacing;
  final ScrollPhysics? physics;
  final double? itemExtent;

  const EventsListHorizontal({
    Key? key,
    required this.events,
    this.spacing = 10.0,
    this.physics,
    this.itemExtent,
  }) : super(key: key);

  @override
  State<EventsListHorizontal> createState() => _EventsListHorizontalState();
}

class _EventsListHorizontalState extends State<EventsListHorizontal> {
  late List<EventItem> _displayEvents;
  int _rotateSeed = 0;

  @override
  void initState() {
    super.initState();
    _displayEvents = List<EventItem>.of(widget.events);
    eventListRefreshBus.addListener(_onRefreshRequested);
  }

  @override
  void didUpdateWidget(covariant EventsListHorizontal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.events, widget.events)) {
      _displayEvents = List<EventItem>.of(widget.events);
    }
  }

  @override
  void dispose() {
    eventListRefreshBus.removeListener(_onRefreshRequested);
    super.dispose();
  }

  void _onRefreshRequested() {
    if (_displayEvents.isEmpty) return;
    setState(() {
      _rotateSeed = (_rotateSeed + 1) % _displayEvents.length;
      _displayEvents = <EventItem>[
        ..._displayEvents.skip(1),
        _displayEvents.first,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasSpacing = widget.spacing > 0;
    final data = _displayEvents;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = hasSpacing ? index ~/ 2 : index;
          if (hasSpacing && index.isOdd) {
            return SizedBox(height: widget.spacing);
          }
          if (itemIndex >= data.length) return const SizedBox.shrink();

          final item = data[itemIndex];
          final stableKey =
              ValueKey('${item.img}|${item.desc.hashCode}'); // key ổn định

          return KeyedSubtree(
            key: stableKey,
            child: _EventCard(item: item),
          );
        },
        childCount: hasSpacing
            ? (data.isNotEmpty ? data.length * 2 - 1 : 0)
            : data.length,
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventItem item;
  const _EventCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dùng Material + InkWell để có ripple + onTap điều hướng
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EventDetailScreen(
                img: item.img,
                desc: item.desc,
              ),
            ),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                item.img,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
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
      ),
    );
  }
}
