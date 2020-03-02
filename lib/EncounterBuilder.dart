import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'Shelf.dart';
import 'package:string_similarity/string_similarity.dart';

class EncounterBuilder extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EncounterBuilderState();
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}

class _EncounterBuilderState extends State<EncounterBuilder>{
  final SearchBarController<Creature> _searchBarController = SearchBarController();
  bool isReplay = false;

  _getAllPosts() {

    List<Creature> posts = [];
    posts.add(Creature("Aboleth", CreatureType.Aberration, 1));
    posts.add(Creature("Badger", CreatureType.Beast, 1));
    posts.add(Creature("Bat", CreatureType.Beast, 1));
    posts.add(Creature("Animated Armor", CreatureType.Construct, 1));
    posts.add(Creature("Flying Sword", CreatureType.Construct, 1));
    posts.add(Creature("Ancient Green Dragon", CreatureType.Dragon, 1));
    posts.add(Creature("Adult Black Dragon", CreatureType.Dragon, 1));
    posts.add(Creature("A J A X ", CreatureType.Player, 1));

    return posts;}

  Future<List<Creature>> searchPosts(String text) async {

    List<Creature> posts = _getAllPosts();
    posts.sort((a, b) => StringSimilarity.compareTwoStrings(b.getSearchString(), text).compareTo(StringSimilarity.compareTwoStrings(a.getSearchString(), text)));

    return posts;
  }

  String dropdownValueTest = "One";
  String dropdownValueCR = "1";
  CreatureType dropdownValueType = CreatureType.Player;

  var Types = CreatureType.values;
  var CR = new List<String>.generate(10, (int index) => index.toString());

  final List<CreatureType> selectedTypes = <CreatureType>[];
  final List<String> selectedCR = <String>[];

  final List<Creature> returnedCreatures = <Creature>[Creature("TEST TEST", CreatureType.Aberration, 1)];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(top:70, bottom:0, child:Container(  child:
              LimitedBox(maxHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width, child:
                new ListView.builder (
                  scrollDirection: Axis.vertical,

                  shrinkWrap: true,
                  itemCount: returnedCreatures.length,
                  itemBuilder: (BuildContext context, int index) { return new Text(returnedCreatures[index].Name); }
                    )
              )
            )),
            SearchBar<Creature>(
//              searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
//              headerPadding: EdgeInsets.symmetric(horizontal: 10),
//              listPadding: EdgeInsets.symmetric(horizontal: 10),
              onSearch: searchPosts,
              searchBarController: _searchBarController,
              emptyWidget: Text("empty"),
              //indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
//          header: Row(
//            children: <Widget>[
//              DropdownButton<CreatureType>(
//                value: selectedTypes.isEmpty ? null : selectedTypes.last,
//                onChanged: (CreatureType newValue) {
//                  setState(() {
//                    if (selectedTypes.contains(newValue))
//                      selectedTypes.remove(newValue);
//                    else
//                      selectedTypes.add(newValue);
//                  });
//                },
//                items: Types.map<DropdownMenuItem<CreatureType>>((CreatureType value) {
//                  return DropdownMenuItem<CreatureType>(
//                    value: value,
//                    child: Row(
//                      mainAxisSize: MainAxisSize.min,
//                      children: <Widget>[
//                        Icon(
//                          Icons.check,
//                          color: selectedTypes.contains(value) ? null : Colors.transparent,
//                        ),
//                        SizedBox(width: 16),
//                        Text(value.toString().substring("CreatureType.".length)),
//                      ],
//                    ),
//                  );
//                })
//                    .toList(),
//              ),
//              DropdownButton<String>(
//                value: selectedCR.isEmpty ? null : selectedCR.last,
//                onChanged: (String newValue) {
//                  setState(() {
//                    if (selectedCR.contains(newValue))
//                      selectedCR.remove(newValue);
//                    else
//                      selectedCR.add(newValue);
//                  });
//                },
//                items: CR.map<DropdownMenuItem<String>>((String value) {
//                  return DropdownMenuItem<String>(
//                    value: value,
//                    child: Row(
//                      mainAxisSize: MainAxisSize.min,
//                      children: <Widget>[
//                        Icon(
//                          Icons.check,
//                          color: selectedCR.contains(value) ? null : Colors.transparent,
//                        ),
//                        SizedBox(width: 16),
//                        Text(value),
//                      ],
//                    ),
//                  );
//                })
//                    .toList(),
//              ),
//            ],
//          ),
//              mainAxisSpacing: 10,
//              crossAxisSpacing: 10,
//              crossAxisCount: 2,
              onItemFound: (Creature post, int index) {
                return Container(color: Colors.white,child:ListTile(
                    title: Text(post.Name),
                    subtitle: Text(post.getTypeString()),
                    onTap: () {returnedCreatures.add(post);setState(() {});}
                ));
              },
            ),
            RaisedButton(
              child: Text('Roll Initative'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EncounterBuilder()),
                );
              },
            )
          ]
        )
      )
    );

  }
}