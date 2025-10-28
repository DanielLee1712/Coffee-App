import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'calculator_platform_interface.dart';

/// An implementation of [CalculatorPlatform] that uses method channels.
class MethodChannelCalculator extends CalculatorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('calculator');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
