import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:numberpicker/numberpicker.dart';
import 'Shelf.dart';
import 'package:string_similarity/string_similarity.dart';

class CombatScreen extends StatefulWidget{

  List<Creature> returnedCreatures;
  CombatScreen({Key key, @required this.returnedCreatures}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CombatScreenState(returnedCreatures: returnedCreatures);
  }
}

class _CombatScreenState extends State<CombatScreen>{
  List<Creature> returnedCreatures;
  _CombatScreenState({Key key, @required this.returnedCreatures});



  SlidableController slidableController;
  bool isReplay = false;

  int numberPicker = 0 ;
  String dropdownValueTest = "One";
  String dropdownValueCR = "1";
  CreatureType dropdownValueType = CreatureType.Player;

  final List<CreatureType> selectedTypes = <CreatureType>[];
  final List<String> selectedCR = <String>[];

  void rotateList(){
    Creature c = returnedCreatures.elementAt(0);
    returnedCreatures = returnedCreatures.skip(1).toList();
    returnedCreatures.add(c);

  }

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
                  Positioned(top:0,width:MediaQuery.of(context).size.width,child: _buildList(context, Axis.vertical)),

                  Positioned(bottom:0,left:50,child:RaisedButton(
                    child: Text('Next Turn'),
                    onPressed: () => setState(() =>{rotateList()},
                  )
                  )
                  )]
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
      child: CombatVerticalListItem(returnedCreatures[index]),
      actions: <Widget>[
        new NumberPicker.integer(
            initialValue: numberPicker,
            itemExtent: 25,
            minValue: -100,
            maxValue: 100,
            onChanged: (newValue) => setState(() => numberPicker = newValue)),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () => _showSnackBar(context, numberPicker>0?'Healed for '+numberPicker.toString():'Damaged for '+numberPicker.toString()),
        ),
        IconSlideAction(
            caption: 'Ref',
            color: Colors.green,
            icon: Icons.info,
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen(creature: item,)));},
        )
      ],
      secondaryActions: _getSliders(item, context),
    );
  }


  List<Widget> _getSliders(Creature item, BuildContext context) {
    int noOfSliders = item.getNoOfConsumableActions();
    if (noOfSliders<1)return null;
    List<Widget> sliders = new List<Widget>(noOfSliders);
    for (int i = 0; i < noOfSliders; i++) {
      sliders[i]=
      new Column(
          children: <Widget>[
            Text(item.ConsumableActions[i].Name),
            Expanded(child: NumberPicker.integer(
                highlightSelectedValue: true,
                initialValue: item.ConsumableActions[i].Value,
                itemExtent: 25,
                minValue: -100,
                maxValue: 100,
                onChanged: (newValue) => setState(() => item.ConsumableActions[i].Value = newValue))
            )
          ]
      );
    }
    return sliders;
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class CombatVerticalListItem extends StatelessWidget {
  CombatVerticalListItem(this.item);
  final Creature item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
          ? Slidable.of(context)?.open()
          : Slidable.of(context)?.close(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: item.getColour(),
            child: Icon(Icons.accessibility),
            foregroundColor: Colors.white,
          ),
          title: Text(item.Name),
          subtitle: Text(item.toString()),
        ),
      ),
    );
  }
}






