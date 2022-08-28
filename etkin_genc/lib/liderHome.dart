import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/constants.dart';
import 'package:untitled3/dashboard.dart';
import 'package:untitled3/profili.dart';
import 'package:untitled3/profilsayafasi.dart';
import 'package:untitled3/randoma.dart';
import 'package:untitled3/widget.dart';
import 'main.dart';

class liderHome extends StatefulWidget {
  const liderHome({Key? key}) : super(key: key);

  @override
  State<liderHome> createState() => _liderHomeState();
}

class _liderHomeState extends State<liderHome> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference etkinlik =
      FirebaseFirestore.instance.collection('Etkinlik Talepleri');

  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  late int puan = 100;
  late int maxPuan = 1000;
  late int kalan = maxPuan - puan;

  var getDataAdSoyad = showName();
  var etkinlikGoster = showActName(Colors.white);

  katil() {
    FirebaseFirestore.instance
        .collection("Onaylanan Etkinlikler")
        .doc(etkinlikGoster.toString())
        .set({
      "KullaniciAdSoyad": getDataAdSoyad,
      "KullaniciEposta": auth.currentUser!.email.toString(),
      "Durum": "ONAYLANDI",
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: showActName(mainColor),
        content: Text("Etkinliği onaylamak istediğinize emin misiniz?"),
        actions: [
          MaterialButton(
              child: Text(
                "Tamam",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              shape: StadiumBorder(),
              minWidth: 150,
              height: 50,
              color: Color(0xff32CD32),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }

  Widget sehirSheet() => Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blueAccent, Colors.greenAccent]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        children: [
          Text(
            "ŞEHİR ROZETİ",
            style: GoogleFonts.bakbakOne(fontSize: 41, color: Colors.white),
          ),
          Text(
            "$puan / $maxPuan",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 46),
          ),
          FaIcon(
            FontAwesomeIcons.streetView,
            color: Colors.white,
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Şehir rozetinin açılmasına kalan puan : $kalan",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ));

  Widget bolgeSheet() => Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blueAccent, Colors.greenAccent]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        children: [
          Text(
            "BÖLGE ROZETİ",
            style: GoogleFonts.bakbakOne(fontSize: 41, color: Colors.white),
          ),
          Text(
            "$puan / $maxPuan",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 46),
          ),
          FaIcon(
            FontAwesomeIcons.map,
            color: Colors.white,
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Bölge rozetinin açılmasına kalan puan : $kalan",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ));

  Widget ulkeSheet() => Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blueAccent, Colors.greenAccent]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        children: [
          Text(
            "ÜLKE ROZETİ",
            style: GoogleFonts.bakbakOne(fontSize: 41, color: Colors.white),
          ),
          Text(
            "$puan / $maxPuan",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 46),
          ),
          FaIcon(
            FontAwesomeIcons.medal,
            color: Colors.white,
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Ülke rozetinin açılmasına kalan puan : $kalan",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ));

  sehirRozet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => sehirSheet());
  }

  bolgeRozet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => bolgeSheet());
  }

  ulkeRozet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => ulkeSheet());
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection('Kullanicilar');

  _getPage(int page) {
    switch (page) {
      case 0:
        return Container(
          color: mainColor,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Container(
                margin: EdgeInsets.only(left: 60),
                child: Text(
                  "ETKİN GENÇ",
                  style: GoogleFonts.bebasNeue(
                    fontStyle: FontStyle.italic,
                    fontSize: 41,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            drawer: Container(
              decoration: BoxDecoration(
                color: mainColor,
              ),
              child: Drawer(
                backgroundColor: Colors.transparent,
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      arrowColor: Colors.green,
                      accountName: showName(),
                      accountEmail: Text(auth.currentUser!.email.toString()),
                      currentAccountPicture: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profilim()));
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/pp.jpg"),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      title: Text(
                        "Profil",
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profilim()));
                      },
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.1,
                    ),
                    ListTile(
                      title:
                          Text("Çıkış", style: TextStyle(color: Colors.white)),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((param) => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Iskele()),
                                  (route) => false)
                            });
                      },
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.1,
                    )
                  ],
                ),
              ),
            ),
            body: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text(
                              "Hoşgeldin, ",
                              style: GoogleFonts.bakbakOne(
                                  fontSize: 27, color: Colors.white),
                            ),
                            showJustName(),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(right: 120),
                      child: Text(
                        "Aktif Etkinlikler",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 34),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: buildScrollList(katil),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      case 1:
        return Profilim();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: _getPage(currentPage),
          ),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          circleColor: mainColor,
          textColor: mainColor,
          activeIconColor: Colors.white,
          inactiveIconColor: mainColor,
          tabs: [
            TabData(
              iconData: Icons.home,
              title: "Anasayfa",
              onclick: () {
                final State<StatefulWidget>? fState =
                    bottomNavigationKey.currentState;
                fState!.setState(() {});
                (2);
              },
            ),
            TabData(
              iconData: Icons.person,
              title: "Profil",
              onclick: () {},
            ),
          ],
          initialSelection: 0,
          key: bottomNavigationKey,
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
      ),
    );
  }
}
