import Flutter
import UIKit

public class CalculatorPlugin: NSObject, FlutterPlugin {
  private static var channel: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let ch = FlutterMethodChannel(name: "calculator", binaryMessenger: registrar.messenger())
    CalculatorPlugin.channel = ch
    let instance = CalculatorPlugin()
    registrar.addMethodCallDelegate(instance, channel: ch)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "calculator" {
      guard let args = call.arguments as? [String: Any],
            let price = args["price"] as? Int,
            let quantity = args["quantity"] as? Int,
            let size = args["size"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing args", details: nil))
        return
      }

      var unitPrice = price
      if size == "S" { unitPrice -= 2 }
      else if size == "L" { unitPrice += 2 }
      if unitPrice < 0 { unitPrice = 0 }

      let totalPrice = unitPrice * quantity

      CalculatorPlugin.channel?.invokeMethod("calculationResult", arguments: [
        "unitPrice": unitPrice,
        "quantity": quantity,
        "totalPrice": totalPrice
      ])
      result(nil)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
