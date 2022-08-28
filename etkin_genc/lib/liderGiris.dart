import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/constants.dart';
import 'package:untitled3/widget.dart';

import 'homepage.dart';
import 'liderHome.dart';
import 'main.dart';

class LiderGirisEkrani extends StatefulWidget {
  const LiderGirisEkrani({Key? key}) : super(key: key);

  @override
  State<LiderGirisEkrani> createState() => _LiderGirisEkraniState();
}

class _LiderGirisEkraniState extends State<LiderGirisEkrani> {
  TextEditingController kullaniciEposta = TextEditingController();

  TextEditingController kullaniciSifre = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  var getDataAd = "";
  var getDataSoyad = "";

  geriDon() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Iskele()),
        (Route<dynamic> route) => false);
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: kullaniciEposta.text, password: kullaniciSifre.text)
        .then((param) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => liderHome()),
            (Route<dynamic> route) => false));
    FirebaseFirestore.instance
        .collection("Kullanicilar")
        .doc(auth.currentUser?.email)
        .get()
        .then((param) {
      setState(() {
        getDataAd = param.data()!['KullaniciAd'];
        getDataSoyad = param.data()!['KullaniciSoyad'];
      });
    });

    final String name = getDataAd;
    final String surname = getDataSoyad;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(130),
            bottomRight: const Radius.circular(130),
          ),
          color: mainColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                            color: girisRengi,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 4),
                                blurRadius: 10,
                              )
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(
                                  child: Column(
                                children: [
                                  Text(
                                    "ETKİN GENÇ",
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: 52,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "LİDER GİRİŞİ",
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: 28,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Center(
                                child: Container(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 50, bottom: 20, top: 30),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: kullaniciEposta,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60))),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent),
                                  ),
                                  labelText: "Lider E-Posta",
                                  labelStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 50, bottom: 20),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                controller: kullaniciSifre,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blueAccent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  labelText: "Lider Şifre",
                                  labelStyle: TextStyle(color: Colors.white),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: girisYap,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: 60,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(60),
                                      boxShadow: [
                                        BoxShadow(
                                          color: mainColor,
                                          offset: Offset(0, 1),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text("Giriş yap",
                                          style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: customButton(geriDon, "Genç Girişi",
                                      Colors.white, secondaryColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
