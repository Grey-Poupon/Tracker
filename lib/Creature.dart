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

  Creature(this.Name, this.Type, this.CR);

  getTypeString(){return Type.toString().substring("CreatureType.".length);}

  getSearchString(){
    if (this.SearchString == null){ this.SearchString = Name + " " + getTypeString();  }
    return this.SearchString;
  }
}

