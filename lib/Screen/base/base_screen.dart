import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/Screen/admin_orders/admin_orders_screen.dart';
import 'package:loja_virtual/Screen/admin_user/admin_user_screen.dart';
import 'package:loja_virtual/Screen/home/home_screen.dart';
import 'package:loja_virtual/Screen/orders/orders_screen.dart';
import 'package:loja_virtual/Screen/products/products_screen.dart';
import 'package:loja_virtual/Screen/stores/stores_screen.dart';



import 'package:loja_virtual/models/page_Manager.dart';
import 'package:loja_virtual/models/user/user_manager.dart';


import 'package:provider/provider.dart';


class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState(){
    super.initState();

    SystemChrome.setPreferredOrientations([
         DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),

          child: Consumer<UserManager>(
            builder: (_,userManager,__){
              return PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),

                  children: <Widget>[
                    // LoginScreen(),
                    HomeScreen(),
                    ProductsScreen(),
                    OrderScreen(),
                    StoresScreen(),
                    if(userManager.adminEnabled)
                      ...[
                       AdminUserScreen(),
                       AdminOrdersScreen()
                      ]
                  ]
              );
            },
          ),
    );
  }
}
