import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/dashboard.dart';
import 'package:untitled3/goRegPage.dart';
import 'package:untitled3/homepage.dart';
import 'package:untitled3/liderGiris.dart';
import 'package:untitled3/profilsayafasi.dart';
import 'package:untitled3/widget.dart';
import 'package:untitled3/yazisayfasi.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Iskele(),
    );
  }
}

class Iskele extends StatefulWidget {
  @override
  State<Iskele> createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  TextEditingController kullaniciEposta = TextEditingController();

  TextEditingController kullaniciSifre = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: kullaniciEposta.text, password: kullaniciSifre.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc(kullaniciEposta.text)
          .set({
        "KullaniciEposta": kullaniciEposta.text,
        "KullaniciSifre": kullaniciSifre.text
      });
    });
  }

  liderGiris() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LiderGirisEkrani()));
  }

  goRegPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const KayitEkrani()));
  }

  static String getDataAd = "";
  static String getDataSoyad = "";

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: kullaniciEposta.text, password: kullaniciSifre.text)
        .then((param) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
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
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: const Radius.circular(130),
              bottomLeft: const Radius.circular(130)),
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
                                    "GİRİŞ",
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
                                  labelText: "E-Posta",
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
                                  labelText: "Şifre",
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
                                      color: Colors.white,
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
                                              color: secondaryColor)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: customButton(
                                      liderGiris,
                                      "Lider Girişi",
                                      secondaryColor,
                                      Colors.white),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      "veya",
                                      style: GoogleFonts.poppins(
                                        color: secondaryColor,
                                      ),
                                    )),
                                GestureDetector(
                                    onTap: goRegPage,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Hesabın yok mu? ",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "Üye ol",
                                          style: GoogleFonts.poppins(
                                              color: secondaryColor,
                                              fontSize: 18),
                                        ),
                                      ],
                                    )),
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
