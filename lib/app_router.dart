import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_ui/login/provider/password_visibility_provider.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';
import 'package:first_ui/home/provider/home_config_provider.dart';

import 'package:first_ui/login/login_screen/login_screen_main.dart';
import 'package:first_ui/cart/cart_screen/cart_screen_main.dart';
import 'package:first_ui/home/home_screen/home_screen_main.dart';
import 'package:first_ui/home/home_screen_view/menu_screen.dart';

class AppRouter {
  static Widget buildApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => HomeMainProvider()),
        ChangeNotifierProvider(create: (_) => HomeConfigProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee App',
        theme: ThemeData(),
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginMain(),
          '/home': (_) => const HomeMain(),
          '/cart': (_) => const CartPage(),
          '/menu': (_) => const MenuScreen(),
          '/menu_screens': (_) => const MenuScreen(),
        },
        onUnknownRoute: (_) =>
            MaterialPageRoute(builder: (_) => const LoginMain()),
      ),
    );
  }
}
