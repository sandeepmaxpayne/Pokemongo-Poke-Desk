import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_data_app/pokemon_data.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;
  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  AnimationStatus animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        animationStatus = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9E9E9E),
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF9E9E9E),
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
          child: Container(
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(1, 3, 2)
                ..rotateY(2 * pi * animation.value),
              child: GestureDetector(
                onTap: () {
                  print(animation.value);
                  if (animationStatus == AnimationStatus.dismissed) {
                    animationController.forward();
                  } else {
                    animationController.reverse();
                  }
                },
                child: animation.value < 0.5
                    ? Card(
                        elevation: 12,
                        color: Color(0xffD7CCC8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(
                              color: Color(0xFF757575),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                            ),
                            Text(
                              widget.pokemon.name,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Height: ${widget.pokemon.height}",
                              style: TextStyle(
                                fontFamily: "Acme",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Text(
                              "Weight: ${widget.pokemon.weight}",
                              style: TextStyle(
                                fontFamily: "Acme",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Text(
                              "Types",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: widget.pokemon.type
                                  .map((pok) => FilterChip(
                                        backgroundColor: Colors.amber,
                                        label: Text(
                                          pok,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        onSelected: (p) {},
                                      ))
                                  .toList(),
                            ),
                            Text(
                              "Weakness",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: widget.pokemon.weaknesses
                                    .map((t) => FilterChip(
                                          backgroundColor: Colors.red.shade300,
                                          label: Text(
                                            t,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onSelected: (b) {},
                                        ))
                                    .toList()),
                            Text(
                              "Next Evolution",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: widget.pokemon.nextEvolution == null
                                    ? <Widget>[Text("Final Evolution Stage")]
                                    : widget.pokemon.nextEvolution
                                        .map((p) => FilterChip(
                                              backgroundColor: Colors.green,
                                              label: Text(
                                                p.name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              onSelected: (b) {},
                                            ))
                                        .toList()),
                          ],
                        ),
                      )
                    : Card(
                        elevation: 12,
                        color: Color(0xffD7CCC8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              widget.pokemon.name,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Candy Details",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 35.0,
                                  backgroundColor: Color(0xFF0D7CCC8),
                                  backgroundImage: AssetImage(
                                    "images/candy1.png",
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Candy: ${widget.pokemon.candy}",
                                      style: TextStyle(
                                        fontFamily: "Acme",
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Candy Count: ${widget.pokemon.candyCcount == null ? 0 : widget.pokemon.candyCcount}",
                                      style: TextStyle(
                                        fontFamily: "Acme",
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              "Poke Egg Hatch",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Color(0xFF0D7CCC8),
                                  backgroundImage: AssetImage("images/egg.png"),
                                ),
                                Text(
                                  "Egg Hatch Distance: ${widget.pokemon.egg}",
                                  style: TextStyle(
                                    fontFamily: "Acme",
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                            Text("Spawn Chance: ${widget.pokemon.spawnChance}"),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Color(0xFF757575))),
                      ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            transitionOnUserGestures: true,
            tag: widget.pokemon.img,
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: NetworkImage(widget.pokemon.img),
                    alignment: Alignment.topCenter),
              ),
            ),
          ),
        )
      ],
    );
  }
}

//String candy;
//int candyCcount;
//String egg;
//String spawnChance;
//String avgSpawn;
//String avgTime;
//List<double> multipliers;
