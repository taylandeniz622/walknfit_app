import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walknfitapp/VeriGirii.dart';
import 'package:walknfitapp/screens/auth/kullanici_giris.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => VeriGirisi()));
                },
                child: Text(
                  'Veri Giiriş',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: KullaniciGiris());
  }
}
