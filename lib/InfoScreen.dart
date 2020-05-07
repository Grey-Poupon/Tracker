
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
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

            PhotoView(imageProvider: AssetImage(creature.reference)),
            Positioned(top:0, left:0,
                child:RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Go back!'),
              )
            )
            ]
          )
        ),

      ),

    );

  }

}