import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/calculator.dart';
import 'package:calculator/calculator_platform_interface.dart';
import 'package:calculator/calculator_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCalculatorPlatform
    with MockPlatformInterfaceMixin
    implements CalculatorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CalculatorPlatform initialPlatform = CalculatorPlatform.instance;

  test('$MethodChannelCalculator is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCalculator>());
  });

  test('getPlatformVersion', () async {
    Calculator calculatorPlugin = Calculator();
    MockCalculatorPlatform fakePlatform = MockCalculatorPlatform();
    CalculatorPlatform.instance = fakePlatform;

    expect(await calculatorPlugin.getPlatformVersion(), '42');
  });
}
