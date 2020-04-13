import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_data_app/pokemon_data.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_data_app/pokemon_details.dart';

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
    setState(() {
      pokeDesk = PokeDesk.fromJson(decodeJson);
    });

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
              children: pokeDesk.pokemon
                  .map((poke) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PokemonDetail(
                                      pokemon: poke,
                                    )));
                      },
                      child: Hero(
                        tag: poke.img,
                        child: Card(
                          child: Column(
//
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
//                                  height:
//                                      MediaQuery.of(context).size.height * 0.4,
//                                  width:
//                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: NetworkImage(poke.img),
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )))
                  .toList(),
            ),
      drawer: Drawer(
        child: Text('drawer'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        backgroundColor: Colors.grey.shade800,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
