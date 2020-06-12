import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walknfitapp/screens/splash_intro/intro_app.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  SpinKitSquareCircle spinkit;

  @override
  void initState() {
    super.initState();
    spinkit = SpinKitSquareCircle(
      color: Colors.green,
      size: 100.0,
      controller:
          AnimationController(vsync: this, duration: Duration(seconds: 3)),
    );
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => IntroPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          spinkit,
          Text(
            'WalknFit',
            style: GoogleFonts.zeyada(textStyle: TextStyle(fontSize: 50)),
          )
        ],
      ),
    );
  }
}
