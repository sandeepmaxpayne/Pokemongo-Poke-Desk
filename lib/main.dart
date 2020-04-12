import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_data_app/pokemon_data.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      title: 'Poke App',
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeDesk pokeDesk;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var request = await http.get(url);
    var decodeJson = jsonDecode(request.body);
    pokeDesk = PokeDesk.fromJson(decodeJson);
    print(pokeDesk);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Poke App',
          style: TextStyle(color: Colors.white38),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
      ),
      body: pokeDesk == null
          ? Center(
              child: SpinKitSquareCircle(
                color: Colors.lightBlueAccent,
                size: 50.0,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeDesk.pokemon.map((poke) => InkWell()),
            ),
    );
  }
}
