import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual/Screen/home/components/add_tile_widget.dart';
import 'package:loja_virtual/Screen/home/components/item_tile.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:provider/provider.dart';


import 'section_header.dart';




class SectionStaggered extends StatelessWidget {

  const SectionStaggered(this.section);
  final Section section;

  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),

           StaggeredGridView.countBuilder(
             padding: EdgeInsets.zero,
             shrinkWrap: true,
             crossAxisCount: 4,
             itemCount: homeManager.editing
             ? section.items.length + 1
             : section.items.length,
             itemBuilder: (_,index){

               if(index < section.items.length)
                 return ItemTile(section.items[index]);
                else 
                  return AddTileWidget(section);
                  
             },
             staggeredTileBuilder: (index) =>
             StaggeredTile.count(2, index.isEven ? 2 : 1),
             mainAxisSpacing: 4,
             crossAxisSpacing: 4,
           )
        ],
      ),
    );
  }
}

