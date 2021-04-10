import 'package:flutter/material.dart';
import 'package:loja_virtual/models/home/home_manager.dart';
import 'package:loja_virtual/models/home/section.dart';

class AddSectionWidget extends StatelessWidget {

  final HomeManager homeManager;

  const AddSectionWidget(this.homeManager);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        Expanded(
          child: FlatButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'List'));
            },
            textColor: Colors.white,
            child: const Text('Adicionar Lista'),
          ),
        ),
        
        Expanded(
          child: FlatButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'Staggered'));
            },
            textColor: Colors.white,
            child: const Text('Adicionar Grade'),
          ),
        )
      ],
    );
  }
}
