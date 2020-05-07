import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CreatureType {
  Aberration,
  Beast,
  Celestial,
  Construct,
  Dragon,
  Elemental,
  Fey,
  Fiend,
  Giant,
  Humanoid,
  Monstrosity,
  Ooze,
  Plant,
  Player,
  SwarmOfTinyBeasts,
  Undead
}

class Creature {

  final String Name;
  final CreatureType Type;
  final int CR;
  String Stats;
  String SearchString = null;
  List<ConsumableAction> ConsumableActions;
  int initiative;
  final String reference;

  Creature(this.Name, this.Type, this.CR, this.reference);

  getTypeString(){return Type.toString().substring("CreatureType.".length);}

  getSearchString(){
    if (this.SearchString == null){ this.SearchString = Name + " " + getTypeString();  }
    return this.SearchString;
  }
  getNoOfConsumableActions(){
    if (ConsumableActions==null){return 0;}
    else return ConsumableActions.length;
  }

  toString(){
    if (Stats==null){return getTypeString();}
    else{return Stats;}
  }

  isInitiativeSet(){return (this.initiative!=null);}

  getColour(){
    switch(this.Type) {
      case CreatureType.Aberration:        {return Colors.red;}break;
      case CreatureType.Beast:             {return Colors.brown;}break;
      case CreatureType.Celestial:         {return Colors.amber;}break;
      case CreatureType.Construct:         {return Colors.amber;}break;
      case CreatureType.Dragon:            {return Colors.black38;}break;
      case CreatureType.Elemental:         {return Colors.red;}break;
      case CreatureType.Fey:               {return Colors.lightGreenAccent;}break;
      case CreatureType.Fiend:             {return Colors.red[300];}break;
      case CreatureType.Giant:             {return Colors.white70;}break;
      case CreatureType.Humanoid:          {return Colors.brown;}break;
      case CreatureType.Monstrosity:       {return Colors.lightGreen;}break;
      case CreatureType.Ooze:              {return Colors.lightGreenAccent;}break;
      case CreatureType.Plant:             {return Colors.green;}break;
      case CreatureType.Player:            {return Colors.deepPurple;}break;
      case CreatureType.SwarmOfTinyBeasts: {return Colors.purpleAccent;}break;
      case CreatureType.Undead:            {return Colors.teal;}break;
      default: {return Colors.white70;}
    }
    }

  void setInitative(int num) {this.initiative = num;}

  static List<Creature> getAllPosts() {

    List<Creature> posts = [];
    posts.add(Creature("Aboleth",              CreatureType.Aberration, 1,  "Assets/Refs/Aboleth.png"));
    posts.add(Creature("Badger",               CreatureType.Beast,      1,  "Assets/Refs/Aboleth.png"));
    posts.add(Creature("Bat",                  CreatureType.Beast,      1,  "Assets/Refs/Aboleth.png"));
    posts.add(Creature("Animated Armor",       CreatureType.Construct,  1,  "Assets/Refs/Aboleth.png"));
    posts.add(Creature("Flying Sword",         CreatureType.Construct,  1,  "Assets/Refs/Aboleth.png"));
    posts.add(Creature("Ancient Green Dragon", CreatureType.Dragon,     1,  "Assets/Refs/Aboleth.png"));
    posts.add(Creature("Adult Black Dragon",   CreatureType.Dragon,     1,  "Assets/Refs/Aboleth.png"));
    posts.add(Creature("AJAX",                 CreatureType.Player,     1,  "Assets/Refs/Aboleth.png"));

    return posts;}

}

class ConsumableAction{
  int Value;
  String Name;

  ConsumableAction(this.Value, this.Name);
}

