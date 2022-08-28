import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:untitled3/main.dart';

import 'constants.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users =
    FirebaseFirestore.instance.collection('Kullanicilar');

CollectionReference etkinlik =
    FirebaseFirestore.instance.collection('Etkinlik Talepleri');

Widget buildLogo(color) => Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "ETKİN",
              style: GoogleFonts.bebasNeue(
                color: color,
                fontSize: 61,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Text(
              "GENÇ",
              style: GoogleFonts.bebasNeue(
                color: color,
                fontSize: 41,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );

Widget customButton(tap, text, color, textColor) => GestureDetector(
      onTap: tap,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: mainColor,
              offset: Offset(0, 1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: textColor,
            ),
          ),
        ),
      ),
    );

Widget etkinlikWidget() => Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 360,
        height: 200,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: mainColor,
              offset: Offset(0, 5),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Katıldığım Etkinlikler",
                style: GoogleFonts.bakbakOne(color: Colors.white, fontSize: 24),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Etkinlik Talepleri")
                  .where("etkinlikAdi")
                  .orderBy("createdAt", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;

                  return SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "  - " + snap[index]['etkinlikAdi'],
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );

Widget buildScrollList(tap) => SizedBox(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Etkinlik Talepleri")
            .where("etkinlikAdi")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!.docs;

            return SingleChildScrollView(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 180,
                          width: 170,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: secondaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snap[index]['etkinlikAdi'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: tap,
                                  child: Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "KATIL",
                                          style: GoogleFonts.bakbakOne(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          } else {
            return Container(
              width: 200,
              height: 100,
              color: Colors.black,
            );
          }
        },
      ),
    );

Widget showName() => FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['KullaniciAd']} ${data['KullaniciSoyad']}",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
          );
        }

        return Text("loading");
      },
    );

Widget showJustName() => FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['KullaniciAd']}" + "!",
            style: GoogleFonts.bakbakOne(fontSize: 27, color: Colors.white),
          );
        }

        return Text("loading");
      },
    );

Widget showJustCity() => FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['KullaniciSehir']}",
            style: GoogleFonts.bakbakOne(fontSize: 27, color: Colors.white),
          );
        }

        return Text("loading");
      },
    );

Widget showActName(color) => FutureBuilder<DocumentSnapshot>(
    future: etkinlik.doc(auth.currentUser!.email).get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }

      if (snapshot.hasData && !snapshot.data!.exists) {
        return Text("Document does not exist");
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return Text(
          "${data['etkinlikAdi']}",
          style: GoogleFonts.bakbakOne(fontSize: 27, color: color),
        );
      }
      return Text("loading");
    });

Widget istatistik(dataMap) => SizedBox(
      height: 400,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Etkinlik Talepleri")
            .where("etkinlikAdi")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!.docs;

            return SingleChildScrollView(
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 400,
                      width: 400,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: secondaryColor,
                      ),
                      child: Column(
                        children: [
                          Text(
                            snap[index]['etkinlikAdi'],
                            style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PieChart(
                            dataMap: dataMap,
                            chartRadius:
                                MediaQuery.of(context).size.width / 1.6,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Container(
              width: 200,
              height: 100,
              color: Colors.black,
            );
          }
        },
      ),
    );
