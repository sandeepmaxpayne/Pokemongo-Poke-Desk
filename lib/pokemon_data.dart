class PokeDesk {
  List<Pokemon> pokemon;

  PokeDesk({this.pokemon});

  PokeDesk.fromJson(Map<String, dynamic> json) {
    if (json['pokemon'] != null) {
      pokemon = List<Pokemon>();
      json['pokemon'].forEach((v) => pokemon.add(Pokemon.fromJson(v)));
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pokemon {
  int id;
  String num;
  String name;
  String img;
  List<String> type;
  String height;
  String weight;
  String candy;
  int candyCcount;
  String egg;
  String spawnChance;
  String avgSpawn;
  String avgTime;
  List<double> multipliers;
  List<String> weaknesses;
  List<NextEvolution> nextEvolution;

  Pokemon(
      {this.id,
      this.num,
      this.name,
      this.height,
      this.weight,
      this.avgSpawn,
      this.avgTime,
      this.candy,
      this.candyCcount,
      this.egg,
      this.img,
      this.multipliers,
      this.nextEvolution,
      this.spawnChance,
      this.type,
      this.weaknesses});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'];
    type = json['type'].cast<String>(); //TODO
    height = json['height'];
    weight = json['weight'];
    candy = json['candy'];
    candyCcount = json['candy_count'];
    egg = json['egg'];
    spawnChance = json['spawn_chance'].toString();
    avgSpawn = json['avg_spawns'].toString();
    avgTime = json['avg_time'];
    multipliers = json['multipliers']?.cast<double>(); // TODO
    weaknesses = json['weaknesses'].cast<String>(); // TODO
    if (json['next_evolution'] != null) {
      nextEvolution = List<NextEvolution>();
      json['next_evolution']
          .forEach((v) => nextEvolution.add(NextEvolution.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['name'] = this.name;
    data['img'] = this.img;
    data['type'] = this.type;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['candy'] = this.candy;
    data['candy_count'] = this.candyCcount;
    data['egg'] = this.egg;
    data['spawn_chance'] = this.spawnChance;
    data['avg_spawns'] = this.avgSpawn.toString();
    data['spawn_time'] = this.avgTime;
    data['multipliers'] = this.multipliers;
    data['weaknesses'] = this.weaknesses;
    if (this.nextEvolution != null) {
      data['next_evolution'] =
          this.nextEvolution.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NextEvolution {
  String num;
  String name;
  NextEvolution({this.name, this.num});

  NextEvolution.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['num'] = this.num;
    data['name'] = this.name;
    return data;
  }
}

//
//"pokemon": [{
//"id": 1,
//"num": "001",
//"name": "Bulbasaur",
//"img": "http://www.serebii.net/pokemongo/pokemon/001.png",
//"type": [
//"Grass",
//"Poison"
//],
//"height": "0.71 m",
//"weight": "6.9 kg",
//"candy": "Bulbasaur Candy",
//"candy_count": 25,
//"egg": "2 km",
//"spawn_chance": 0.69,
//"avg_spawns": 69,
//"spawn_time": "20:00",
//"multipliers": [1.58],
//"weaknesses": [
//"Fire",
//"Ice",
//"Flying",
//"Psychic"
//],
//"next_evolution": [{
//"num": "002",
//"name": "Ivysaur"
//}, {
//"num": "003",
//"name": "Venusaur"
//
