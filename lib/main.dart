import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/address/address_screen.dart';
import 'package:loja_virtual/Screen/edit_product/edit_product_screen.dart';
import 'package:loja_virtual/Screen/select_product/select_product_screen.dart';

import 'package:loja_virtual/Screen/signup/signup_screen.dart';
import 'package:loja_virtual/models/admin_user_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

import 'Screen/base/base_screen.dart';
import 'Screen/cart/cart_screen.dart';
import 'Screen/login/login_screen.dart';
import 'Screen/product/product_tela.dart';
import 'models/cart_manager.dart';
import 'models/home_manager.dart';
import 'models/product.dart';
import 'models/product_manager.dart';

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
        ChangeNotifierProvider(create: (_) => HomeManager(), lazy: false),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUserManager>(
          create: (_) => AdminUserManager(),
          lazy: false,
          update: (_, userManager, adminUserManager) =>
              adminUserManager..updateUser(userManager),
        )
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
              return MaterialPageRoute(builder: (_) => LoginScreen());

            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());

            case '/address':
              return MaterialPageRoute(builder: (_) => AddressScreen());

            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));

            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());

            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductTela(settings.arguments as Product));

            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
