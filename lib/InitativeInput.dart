import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:numberpicker/numberpicker.dart';
import 'Creature.dart';
import 'Shelf.dart';
import 'package:string_similarity/string_similarity.dart';

class InitativeInput extends StatefulWidget{
  List<Creature> returnedCreatures;
  InitativeInput({Key key, @required this.returnedCreatures}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InitativeInputState(returnedCreatures: returnedCreatures);
  }
}

class _InitativeInputState extends State<InitativeInput>{

  List<Creature> returnedCreatures;
  _InitativeInputState({Key key, @required this.returnedCreatures});
  SlidableController slidableController;
  bool isReplay = false;


  int numberPicker = 0 ;
  String dropdownValueTest = "One";
  String dropdownValueCR = "1";
  CreatureType dropdownValueType = CreatureType.Player;

  @protected
  void initState() {
    slidableController = SlidableController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(resizeToAvoidBottomInset : false,
        body: SafeArea(
            child:
            Stack(fit: StackFit.expand,
                children:<Widget>[
                  _buildList(context, Axis.vertical),
                  Positioned(bottom:0,left:50,child:RaisedButton(
                    child: Text('Auto Roll'),
                    onPressed: () {Navigator.of(context).push( MaterialPageRoute(builder: (context) => CombatScreen(returnedCreatures: returnedCreatures,)), );},
                  )
                  )
                ]
            )
        )
    );

  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
        direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        return _getSlidableWithLists(context, index, slidableDirection);
      },
      itemCount: returnedCreatures.length,
    );
  }

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    final Creature item = returnedCreatures[index];
    //final int t = index;
    return Slidable(
      key: Key(item.Name),
      controller: slidableController,
      direction: direction,
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      child: InitativeVerticalListItem(returnedCreatures[index])
    );
  }


  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class InitativeVerticalListItem extends StatelessWidget {
  InitativeVerticalListItem(this.item);
  final Creature item;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
          leading:
             Container(
                width:50.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Initative'
                      ),
                  )
                ),
            title: Text(item.Name),
            subtitle: Text(item.toString()),
             trailing: CircleAvatar(
                 backgroundColor: item.getColour(),
                 child: Icon(Icons.accessibility),
                 foregroundColor: Colors.white,
                ),
    ));
//        child:  TextField(
//              keyboardType: TextInputType.number,
//              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
//              decoration: InputDecoration(
//                  border: InputBorder.none,
//                  hintText: 'Enter a search term'
//              ),
//              onChanged: (num){
//                item.setInitative(int.tryParse(num) ?? 0);
//              }
//          )
//                  )
//        );
  }
}






