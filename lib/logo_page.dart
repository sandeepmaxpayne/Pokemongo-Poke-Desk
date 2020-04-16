import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF616161),
      body: Center(
        child: SplashScreen.navigate(
          name: 'assets/podexLogo.flr',
          next: (context) => HomePage(),
          until: () => Future.delayed(Duration(seconds: 6)),
          fit: BoxFit.cover,
          loopAnimation: 'go',
        ),
      ),
    );
  }
}
//FlareActor(
//,
//animation: "go",
//),,
