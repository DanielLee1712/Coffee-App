import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:first_ui/home/model/event_item.dart';

enum HomeConfigStatus { loading, loaded, error }

class HomeConfigProvider extends ChangeNotifier {
  List<EventItem> _events = [];
  List<EventItem> get events => _events;

  String? _eventsTitle;
  String? get eventsTitle => _eventsTitle;

  HomeConfigStatus _status = HomeConfigStatus.loading;
  HomeConfigStatus get status => _status;

  Future<void> loadConfig({bool simulateError = false}) async {
    _status = HomeConfigStatus.loading;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (simulateError) {
        throw Exception("Fake error for testing");
      }

      final String response =
          await rootBundle.loadString('lib/home/model/home.json');
      final data = jsonDecode(response);

      final List<dynamic> eventsJson = data['events'];
      _events = eventsJson.map((e) => EventItem.fromJson(e)).toList();

      try {
        final sections = data['sections'] as List<dynamic>;
        final titleSection = sections.firstWhere(
          (s) => s['id'] == 'events_title' && (s['enabled'] ?? true),
          orElse: () => {},
        );
        if (titleSection is Map<String, dynamic>) {
          _eventsTitle = titleSection['text'] as String?;
        }
      } catch (_) {
        _eventsTitle = null;
      }

      _status = HomeConfigStatus.loaded;
    } catch (e) {
      if (kDebugMode) {
        print("Error loading home.json: $e");
      }
      _status = HomeConfigStatus.error;
    }

    notifyListeners();
  }
}
