import 'package:flutter/material.dart';
import 'package:loja_virtual/Screen/home/components/sectionStaggered.dart';
import 'package:loja_virtual/Screen/home/components/section_list.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),

      // App flutuante
      body:Stack(
        children:<Widget> [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color.fromARGB(255, 200, 118, 130),
                  Color.fromARGB(255, 253, 181, 168),
                ],
                  begin: Alignment.topCenter,
                end:Alignment.bottomCenter
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap:true,
                floating: true,
                elevation: 0,
                backgroundColor:Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title:Text('Loja do Higino'),
                  centerTitle:true,
                ),
                actions: <Widget>[

                  IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
  
                   Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __){
                      
                      if(userManager.adminEnabled){

                        if(homeManager.editing){
                           return PopupMenuButton(


                             itemBuilder: (_){

                               return['Salvar','Descartar'].map((e){
                                 return PopupMenuItem(
                                   value: e,
                                   child: Text(e),
                                 );
                               }).toList();
                             },
                           );
                        }else{
                          return IconButton(
                           icon: Icon(Icons.edit),
                           onPressed: homeManager.enterEditing
                         );
                        }
                      
                      }  else return Container();
          
                    }
                  )
                  
                ],
              ),
            Consumer<HomeManager>(
              builder: (_, homeManager, __){

                final List<Widget> cheldren = homeManager.sections.map<Widget>(
                        (section) {
                          switch(section.type){
                            case 'List':
                              return SectionList(section);
                            case 'Staggered':
                              return SectionStaggered(section);
                            default:
                              return Container();
                          }
                        }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(cheldren),
                );
              }
             )
            ]
          ),
        ],
      )
    );
  }
}
