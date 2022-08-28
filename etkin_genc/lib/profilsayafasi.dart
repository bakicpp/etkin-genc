import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:untitled3/constants.dart';
import 'package:untitled3/widget.dart';

class Basarilarim extends StatefulWidget {
  const Basarilarim({Key? key}) : super(key: key);

  @override
  State<Basarilarim> createState() => _BasarilarimState();
}

class _BasarilarimState extends State<Basarilarim> {
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Java": 2,
    "Python": 4,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: 120),
          child: Text(
            "ETKIN GENC",
            style: GoogleFonts.bebasNeue(
              fontStyle: FontStyle.italic,
              fontSize: 41,
            ),
          ),
        ),
        backgroundColor: mainColor,
      ),
      body: Container(
        color: mainColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                "İstatistikler",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 41,
                ),
              ),
              istatistik(dataMap),
            ],
          ),
        ),
      ),
    );
  }
}
