import 'package:flutter/material.dart';

class LoadPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadPageState();
  }
}
class _LoadPageState extends State<LoadPage>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:
    Scaffold(
      appBar: AppBar(
        title: Text('Load Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    )
    );
  }

}