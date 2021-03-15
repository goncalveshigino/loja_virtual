import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/admin_user/admin_user_screen.dart';
import 'package:loja_virtual/Screen/home/home_screen.dart';
import 'package:loja_virtual/Screen/products/products_screen.dart';

import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_Manager.dart';
import 'package:loja_virtual/models/user_manager.dart';

import 'package:provider/provider.dart';


class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

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
                    Scaffold(
                      drawer: CustomDrawer(),
                      appBar: AppBar(
                        title: const Text('Meus Pedidos'),
                      ),
                    ),
                    Scaffold(
                      drawer: CustomDrawer(),
                      appBar: AppBar(
                        title: const Text('Lojas'),
                      ),
                    ),
                    if(userManager.adminEnabled)
                      ...[
                       AdminUserScreen(),
                        Scaffold(
                          drawer: CustomDrawer(),
                          appBar: AppBar(
                            title: const Text('Pedidos'),
                          ),
                        )
                      ]
                  ]
              );
            },
          ),
    );
  }
}
