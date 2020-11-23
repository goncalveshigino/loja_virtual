import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/products/products_screen.dart';

import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_Manager.dart';
import 'package:provider/provider.dart';


class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),

          child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),

          children: <Widget>[
            // LoginScreen(),
              Scaffold(

               drawer: CustomDrawer(),
               appBar: AppBar(
                 title: const Text('Home'),
               ),
             ),
              ProductsScreen(),
              Scaffold(

               drawer: CustomDrawer(),
               appBar: AppBar(
                 title: const Text('Home3'),
               ),
             ),
             Scaffold(

               drawer: CustomDrawer(),
               appBar: AppBar(
                 title: const Text('Home4'),
               ),
             ),
          ]),
    );
  }
}
