import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_data_app/logo_page.dart';
import 'package:pokemon_data_app/pokemon_data.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_data_app/pokemon_details.dart';

void main() => runApp(MaterialApp(
      color: Color(0xFF616161),
      home: LogoScreen(),
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
      backgroundColor: Color(0xFFD7CCC8),
      appBar: AppBar(
        elevation: 6.0,
        title: Text(
          'Pokedex',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF9E9E9E),
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
              shrinkWrap: true,
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
                        transitionOnUserGestures: true,
                        tag: poke.img,
                        child: Card(
                          elevation: 5.1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                          ),
                          color: Color(0xFFD7CCC8),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        backgroundColor: Color(0xFF9E9E9E),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
