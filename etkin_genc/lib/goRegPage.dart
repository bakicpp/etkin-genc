import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/constants.dart';
import 'package:untitled3/main.dart';
import 'package:untitled3/widget.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({Key? key}) : super(key: key);

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  TextEditingController kullaniciEposta = TextEditingController();
  TextEditingController kullaniciSifre = TextEditingController();
  TextEditingController kullaniciAd = TextEditingController();
  TextEditingController kullaniciSoyad = TextEditingController();
  TextEditingController kullaniciTelefon = TextEditingController();
  TextEditingController kullaniciSehir = TextEditingController();

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: kullaniciEposta.text,
      password: kullaniciSifre.text,
    )
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc(kullaniciEposta.text)
          .set({
        "KullaniciEposta": kullaniciEposta.text,
        "KullaniciSifre": kullaniciSifre.text,
        "KullaniciAd": kullaniciAd.text,
        "KullaniciSoyad": kullaniciSoyad.text,
        "KullaniciTelefon": kullaniciTelefon.text,
        "KullaniciSehir": kullaniciSehir.text,
      });
    });
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Text("KAYDOL"),
        content: Text("Kayıt başarıyla gerçekleştirildi!"),
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

  geriDon() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Iskele()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
          color: secondaryColor,
        ),
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text(
                  "KAYDOL    ",
                  style: GoogleFonts.bakbakOne(
                    fontSize: 41,
                    color: Colors.white,
                  ),
                ),
              )),
          backgroundColor: Colors.transparent,
          body: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 400,
                        height: 900,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white54, Colors.white60],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            buildLogo(Colors.white),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                              child: TextField(
                                controller: kullaniciAd,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelText: "Ad",
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
                                controller: kullaniciSoyad,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelText: "Soyad",
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
                                controller: kullaniciEposta,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelText: "E-mail",
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
                                obscureText: true,
                                controller: kullaniciSifre,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelText: "Şifre",
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
                                controller: kullaniciTelefon,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelText: "Telefon",
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
                                controller: kullaniciSehir,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2.0),
                                  ),
                                  labelText: "Şehir",
                                  labelStyle: TextStyle(color: mainColor),
                                  prefixIcon: Icon(
                                    Icons.local_activity_rounded,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: kayitOl,
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 150,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.greenAccent,
                                    Colors.blueAccent
                                  ]),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Center(
                                  child: Text(
                                    "Kaydol",
                                    style: GoogleFonts.bakbakOne(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                  onTap: geriDon,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Zaten hesabın var mı? ",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        "Giriş yap",
                                        style: GoogleFonts.poppins(
                                            color: secondaryColor,
                                            fontSize: 18),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        )),
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
