import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_ui/login/provider/password_visibility_provider.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';

import 'package:first_ui/login/login_screen/login_screen_main.dart';
import 'package:first_ui/cart/cart_screen/cart_screen_main.dart';
import 'package:first_ui/home/home_screen/home_screen_main.dart';
import 'package:first_ui/home/home_screen_view/menu_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
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
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: NoTransitionsBuilder(),
              TargetPlatform.iOS: NoTransitionsBuilder(),
              TargetPlatform.macOS: NoTransitionsBuilder(),
              TargetPlatform.linux: NoTransitionsBuilder(),
              TargetPlatform.windows: NoTransitionsBuilder(),
              TargetPlatform.fuchsia: NoTransitionsBuilder(),
            },
          ),
        ),
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
