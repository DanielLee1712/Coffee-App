import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/providers/password_visibility_provider.dart';
import 'package:first_ui/providers/cart_provider.dart';
import 'package:first_ui/providers/home_main_provider.dart';
import 'package:first_ui/screens/login_main.dart';
import 'package:first_ui/screens/cart_main.dart';
import 'package:first_ui/screens/home_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => HomeMainProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginMain(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (context) => const LoginMain());
            case '/home':
              return MaterialPageRoute(builder: (context) => const HomeMain());
            case '/cart':
              return MaterialPageRoute(builder: (context) => const CartPage());
            default:
              return MaterialPageRoute(builder: (context) => const LoginMain());
          }
        },
      ),
    );
  }
}
