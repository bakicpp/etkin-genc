import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/homepage.dart';

class Randoma extends StatefulWidget {
  @override
  State<Randoma> createState() => _RandomState();
}

class _RandomState extends State<Randoma> {
  final index = Random().nextInt(4);

  List gorevler = [
    "birinci gorev",
    "ikinci gorev",
    "ucuncu gorev",
    "dorduncu gorev",
    "besinci gorev",
  ];

  List image = [
    "images/konseypng.png",
    "images/pp.jpg",
    "images/bu1.jpg",
    "images/bu2.jpg",
    "images/emlak.jpg",
  ];

  late String mImage = image[index];
  late String gorev = gorevler[index];

  tamam() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Randoma()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orangeAccent],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          offset: Offset(16, 16),
                          blurRadius: 24,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        mImage,
                        scale: 8,
                      ),
                      Text(
                        gorev,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 41,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: tamam,
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.greenAccent, Colors.blueAccent]),
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0, -2),
                          blurRadius: 15,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "TAMAM",
                      style: GoogleFonts.bakbakOne(
                          fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
