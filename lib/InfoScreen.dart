
import 'package:flutter/material.dart';
import 'package:zoomable_image/zoomable_image.dart';

import 'Creature.dart';

class InfoScreen extends StatelessWidget {

  Creature creature;
  InfoScreen({Key key, @required this.creature}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: Text(creature.Name),
        ),

        body: Center(child: Stack( children: <Widget>[

          ZoomableImage(AssetImage(creature.reference), maxScale: 1.0 , minScale: 2.0,),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
              )
            ]
          )
        ),

      ),

    );

  }

}