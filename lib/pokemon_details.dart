import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemon_data_app/pokemon_data.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  PokemonDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: Text(pokemon.name),
        elevation: 0.0,
        backgroundColor: Colors.greenAccent,
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width - 20,
          top: MediaQuery.of(context).size.height * 0.1,
          left: 10.0,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 70.0,
                ),
                Text(
                  pokemon.name,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text("Height: ${pokemon.height}"),
                Text("Weight: ${pokemon.weight}"),
                Text(
                  "Types",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pokemon.type
                      .map((pok) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(pok),
                            onSelected: (p) {},
                          ))
                      .toList(),
                ),
                Text(
                  "Weakness",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((t) => FilterChip(
                              backgroundColor: Colors.red,
                              label: Text(t),
                              onSelected: (b) {},
                            ))
                        .toList()),
                Text(
                  "Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution == null
                        ? <Widget>[Text("Final Evolution Stage")]
                        : pokemon.nextEvolution
                            .map((p) => FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    p.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onSelected: (b) {},
                                ))
                            .toList()),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
            ),
          ),
        )
      ],
    );
  }
}
