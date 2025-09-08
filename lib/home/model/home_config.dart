import 'dart:convert';

import 'package:flutter/services.dart';

class SectionSlot {
  final String id;
  final bool enabled;
  final String? text;
  const SectionSlot({required this.id, this.enabled = true, this.text});

  factory SectionSlot.fromJson(Map<String, dynamic> j) => SectionSlot(
        id: j['id'] as String,
        enabled: j['enabled'] as bool? ?? true,
        text: j['text'] as String?,
      );
}

class EventConfig {
  final int visibleCount;
  final bool shuffleOnRefresh;
  final List<Map<String, String>> items;

  EventConfig({
    required this.visibleCount,
    required this.shuffleOnRefresh,
    required this.items,
  });

  factory EventConfig.fromJson(Map<String, dynamic> j) => EventConfig(
        visibleCount: j['visibleCount'] ?? 4,
        shuffleOnRefresh: j['shuffleOnRefresh'] ?? true,
        items: (j['items'] as List)
            .map((e) => {'img': e['img'], 'desc': e['desc']})
            .cast<Map<String, String>>()
            .toList(),
      );
}

class MenuItemConfig {
  final String id;
  final String title;
  final String icon;
  final String route;
  const MenuItemConfig({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
  });

  factory MenuItemConfig.fromJson(Map<String, dynamic> j) => MenuItemConfig(
        id: j['id'],
        title: j['title'],
        icon: j['icon'],
        route: j['route'],
      );
}

class HomeConfig {
  final List<SectionSlot> sections;
  final EventConfig eventList;
  final List<MenuItemConfig> menuItems;

  HomeConfig({
    required this.sections,
    required this.eventList,
    required this.menuItems,
  });

  factory HomeConfig.fromJson(Map<String, dynamic> j) => HomeConfig(
        sections: (j['sections'] as List)
            .map((e) => SectionSlot.fromJson(e))
            .toList(),
        eventList: EventConfig.fromJson(j['event_list']),
        menuItems: (j['menu']['items'] as List)
            .map((e) => MenuItemConfig.fromJson(e))
            .toList(),
      );

  static Future<HomeConfig> loadFromAsset(String path) async {
    final raw = await rootBundle.loadString(path);
    return HomeConfig.fromJson(jsonDecode(raw));
  }
}
