import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: yaziIskelesi(),
    );
  }
}

class yaziIskelesi extends StatefulWidget {
  @override
  State<yaziIskelesi> createState() => _yaziIskelesiState();
}

class _yaziIskelesiState extends State<yaziIskelesi> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var gelenYaziBasligi = '';
  var gelenYaziIcerigi = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  yaziEkle() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).set({
      "kullaniciid": auth.currentUser!.uid,
      "baslik": t1.text,
      "icerik": t2.text
    });
  }

  yaziSil() {
    FirebaseFirestore.instance.collection("Yazilar").doc(t1.text).delete();
  }

  yaziGuncelle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .update({"baslik": t1.text, "icerik": t2.text});
  }

  yaziGetir() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .get()
        .then((param) {
      setState(() {
        gelenYaziIcerigi = param.data()!['baslik'];
        gelenYaziBasligi = param.data()!['icerik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yazılar"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: t1,
              ),
              TextFormField(
                controller: t2,
              ),
              Row(
                children: [
                  RaisedButton(onPressed: yaziEkle, child: Text("Ekle")),
                  RaisedButton(
                    onPressed: yaziSil,
                    child: Text("Sil"),
                  ),
                  RaisedButton(
                    onPressed: yaziGetir,
                    child: Text("Gör"),
                  ),
                  RaisedButton(
                    onPressed: yaziGuncelle,
                    child: Text("Güncelle"),
                  ),
                ],
              ),
              ListTile(
                title: Text(gelenYaziBasligi),
                subtitle: Text(gelenYaziIcerigi),
              )
            ],
          ),
        ),
      ),
    );
  }
}
