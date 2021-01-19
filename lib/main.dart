import 'package:flutter/material.dart';

import 'package:loja_virtual/Screen/signup/signup_screen.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'Screen/base/base_screen.dart';
import 'Screen/cart/cart_screen.dart';
import 'Screen/login/login_screen.dart';
import 'Screen/product/product_tela.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),

        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
          ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update:  (_, userManager, cartManager) => 
          cartManager..updateUser(userManager),
        ),
        
      ],
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Loja do Higino',
          theme: ThemeData(
              primaryColor: const Color.fromARGB(255, 4, 125, 141),
              scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
              appBarTheme: const AppBarTheme(
                elevation: 0,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity),
          initialRoute: '/base',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/base':
                return MaterialPageRoute(builder: (_) => BaseScreen());
              case '/signup':
                return MaterialPageRoute(builder: (_) => SignUpScreen());
              case '/login':
                return MaterialPageRoute(
                  builder: (_) => LoginScreen()
                );
              case '/cart':
                return MaterialPageRoute(
                  builder: (_) => CartScreen()
                );
                  case '/product':
                return MaterialPageRoute(
                  builder: (_) => ProductTela(
                    settings.arguments as Product
                   )
                );
              default:
                return MaterialPageRoute(builder: (_) => BaseScreen());
            }
          },
        ),
      );
  }
}
