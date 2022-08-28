import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/constants.dart';
import 'package:untitled3/widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Profilim extends StatefulWidget {
  const Profilim({Key? key}) : super(key: key);

  @override
  State<Profilim> createState() => _ProfilimState();
}

class _ProfilimState extends State<Profilim> {
  FirebaseAuth auth = FirebaseAuth.instance;

  launchURL() async {
    const url = 'https://twitter.com/home?lang=tr';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mainColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              "PROFİLİM     ",
              style: GoogleFonts.bakbakOne(
                fontSize: 41,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: mainColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    maxRadius: 70,
                    backgroundImage: AssetImage(
                      "images/pp.jpg",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  //data geldiğinde kullanıcı isim soyisim yazacak
                  child: showName(),
                ),
                showJustCity(),
                Text(
                  auth.currentUser!.email.toString(),
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 19),
                ),
                etkinlikWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
