import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/section.dart';
import 'package:provider/provider.dart';

class  SectionHeader extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

        final homeManager = context.watch<HomeManager>();
        final section = context.watch<Section>();

        if(homeManager.editing){
          return Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      initialValue: section.name,
                      decoration: const InputDecoration(
                        hintText: 'Titulo',
                        isDense: true,
                        border: InputBorder.none
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18
                      ),
                      onChanged: (text) => section.name = text,
                    ),
                  ),

                  CustomIconButton(
                     iconData: Icons.remove,
                     color: Colors.white,
                     onTap: (){
                       homeManager.removeSection(section);
                     },
                  )
                ],
              ),
              if(section.error != null)
                  Text(
                    section.error,
                    style: const TextStyle(
                      color: Colors.red
                    ),
                  )
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              section.name ?? "Banana",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          );
        }
    
  }
}
