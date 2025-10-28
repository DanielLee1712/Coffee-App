import 'dart:async';
import 'package:flutter/services.dart';

class Calculator {
  static const _channel = MethodChannel("calculator");
  static final _controller = StreamController<Map<String, dynamic>>.broadcast();
  static bool _initialized = false;

  static void _ensureInitialized() {
    if (_initialized) return;

    _channel.setMethodCallHandler((call) async {
      if (call.method == "calculationResult") {
        final args = Map<String, dynamic>.from(call.arguments);
        _controller.add(args);
      }
    });

    _initialized = true;
  }

  static Stream<Map<String, dynamic>> get resultStream {
    _ensureInitialized();
    return _controller.stream;
  }

  static Future<void> calculate(int price, int quantity, String size) async {
    _ensureInitialized();
    await _channel.invokeMethod("calculator", {
      "price": price,
      "quantity": quantity,
      "size": size,
    });
  }

  static Future<Map<String, dynamic>> calculateOnce(
    int price,
    int quantity,
    String size,
  ) async {
    _ensureInitialized();
    await _channel.invokeMethod("calculator", {
      "price": price,
      "quantity": quantity,
      "size": size,
    });
    return await _controller.stream.first;
  }
}
