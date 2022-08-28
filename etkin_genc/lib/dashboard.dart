import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/constants.dart';
import 'package:untitled3/widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController etkinlikAdi = TextEditingController();
  TextEditingController telefon = TextEditingController();
  TextEditingController konum = TextEditingController();
  TextEditingController tarihSaat = TextEditingController();
  TextEditingController kisiSayisi = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  etkinlikOlustur() {
    if (etkinlikAdi.text.isEmpty ||
        telefon.text.isEmpty ||
        konum.text.isEmpty ||
        tarihSaat.text.isEmpty ||
        kisiSayisi.text.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text("UYARI"),
          content: Text("Lütfen tüm alanları doldurun!"),
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
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      );
    } else {
      FirebaseFirestore.instance
          .collection("Etkinlik Talepleri")
          .doc(auth.currentUser!.email)
          .set({
        "kullaniciid": auth.currentUser!.uid,
        "kullaniciEposta": auth.currentUser!.email,
        "etkinlikAdi": etkinlikAdi.text,
        "telefon": telefon.text,
        "konum": konum.text,
        "tarih-saat": tarihSaat.text,
        "kisiSayisi": kisiSayisi.text,
        "createdAt": DateTime.now(),
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text("Etkinlik Oluştur"),
          content: Text("Etkinlik talebin başarıyla oluşturuldu!"),
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
                "ETKİNLİK OLUŞTUR",
                style: GoogleFonts.bakbakOne(
                  fontSize: 41,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            )),
        backgroundColor: Colors.transparent,
        body: Container(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 400,
                      height: 900,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          buildLogo(mainColor),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                            child: TextField(
                              controller: etkinlikAdi,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: mainColor, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                labelText: "Etkinlik Adı",
                                labelStyle: TextStyle(color: mainColor),
                                prefixIcon: Icon(
                                  Icons.local_activity_rounded,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                            child: TextField(
                              controller: telefon,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: mainColor, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                labelText: "Telefon",
                                labelStyle: TextStyle(color: mainColor),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                            child: TextField(
                              controller: konum,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: mainColor, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                labelText: "Etkinlik Konumu",
                                labelStyle: TextStyle(color: mainColor),
                                prefixIcon: Icon(
                                  Icons.location_on_sharp,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                            child: TextField(
                              controller: tarihSaat,
                              decoration: InputDecoration(
                                fillColor: secondaryColor,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: mainColor, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                labelText: "Tarih / Saat",
                                labelStyle: TextStyle(color: mainColor),
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                            child: TextField(
                              controller: kisiSayisi,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: mainColor, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                labelText: "Kişi Sayısı",
                                labelStyle: TextStyle(color: mainColor),
                                prefixIcon: Icon(
                                  Icons.people,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: etkinlikOlustur,
                            child: Container(
                              margin: EdgeInsets.only(top: 40),
                              width: 150,
                              height: 60,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Center(
                                child: Text(
                                  "GÖNDER",
                                  style: GoogleFonts.bakbakOne(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
