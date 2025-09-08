// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart';
// import 'package:first_ui/home/model/event_item.dart';

// class HomeConfigProvider extends ChangeNotifier {
//   List<EventItem> _events = [];
//   List<EventItem> get events => _events;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   Future<void> loadConfig() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final String response =
//           await rootBundle.loadString('lib/home/model/home.json');
//       final data = jsonDecode(response);

//       final List<dynamic> eventsJson = data['events'];
//       _events = eventsJson.map((e) => EventItem.fromJson(e)).toList();
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error loading home.json: $e");
//       }
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }

// // 1 loading
// // 2 loaded
// // 3 error
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:first_ui/home/model/event_item.dart';

enum HomeConfigStatus { loading, loaded, error }

class HomeConfigProvider extends ChangeNotifier {
  List<EventItem> _events = [];
  List<EventItem> get events => _events;

  HomeConfigStatus _status = HomeConfigStatus.loading;
  HomeConfigStatus get status => _status;

  Future<void> loadConfig({bool simulateError = false}) async {
    _status = HomeConfigStatus.loading;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (simulateError) {
        throw Exception("Fake error for testing");
      }

      final String response =
          await rootBundle.loadString('lib/home/model/home.json');
      final data = jsonDecode(response);

      final List<dynamic> eventsJson = data['events'];
      _events = eventsJson.map((e) => EventItem.fromJson(e)).toList();

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
