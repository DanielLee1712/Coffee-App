import 'package:flutter/material.dart';
import 'package:calculator/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Calculator Demo")),
        body: Center(
          child: StreamBuilder<Map<String, dynamic>>(
            stream: Calculator.resultStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return ElevatedButton(
                  onPressed: () {
                    Calculator.calculate(100, 2, "L");
                  },
                  child: const Text("Tính toán"),
                );
              }
              final data = snapshot.data!;
              return Text(
                "Unit: ${data['unitPrice']}, Qty: ${data['quantity']}, Total: ${data['totalPrice']}",
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ),
      ),
    );
  }
}
