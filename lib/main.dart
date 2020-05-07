import 'dart:math';
import 'package:flutter/material.dart';
import 'Shelf.dart';

main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:_HomePageHome());
  }
}
class _HomePageHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
        ),
        body: Center(child:
          Column(children: <Widget>[
              RaisedButton(
                child: Text('New'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EncounterBuilder()),
                  );
                },
              ),
              RaisedButton(
                child: Text('Load'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoadPage()),
                  );
                },
              ),
          ]
          )
        ),
      );

  }

}






