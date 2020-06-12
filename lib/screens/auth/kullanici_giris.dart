import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:walknfitapp/commons/button/button.dart';
import 'package:walknfitapp/screens/auth/kullanici_bilgileri.dart';
import 'package:walknfitapp/screens/auth/kullanici_kayit.dart';

import 'package:walknfitapp/user_model/user_view_model.dart';

class KullaniciGiris extends StatefulWidget {
  @override
  _KullaniciGirisState createState() => _KullaniciGirisState();
}

class _KullaniciGirisState extends State<KullaniciGiris> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _mailCont = TextEditingController();
  String mail;
  String sifre;
  bool _gizli = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mailCont = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Hoşgeldiniz',
              style: GoogleFonts.zeyada(
                  textStyle: TextStyle(fontSize: 50, color: Colors.teal)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _mailCont,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => _validateEmail(value),
                      onSaved: (value) {
                        mail = value;
                      },
                      decoration: InputDecoration(
                        suffix: Icon(Icons.alternate_email),
                        hintText: 'example@example.com',
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) => isPasswordCompliant(value),
                      obscureText: _gizli,
                      onSaved: (value) {
                        sifre = value;
                      },
                      decoration: InputDecoration(
                        suffix: GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              _gizli = !_gizli;
                            });
                          },
                          child: _gizli
                              ? Icon(Icons.lock_outline)
                              : Icon(Icons.lock_open),
                        ),
                        hintText: 'Şifre Giriniz',
                        labelText: 'Şifre',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                          onPressed: () => _sifremiUnuttum(mail),
                          child: Text('Şifremi Unuttum')),
                    ),
                    SizedBox(height: 20),
                    CommonButton(
                      text: Text('Giriş'),
                      color: Colors.green,
                      radius: 20,
                      onPressed: _girisYap,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Hemen Kayıt Ol :)'),
                    CommonButton(
                        text: Text('Kayıt'),
                        color: Colors.teal,
                        radius: 20,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => KullaniciKayit()),
                          );
                        }),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "E-posta Adresi Giriniz!";
    }
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Geçersiz E-posta !';
  }

  void _girisYap() {
    final userModel = Provider.of<UserModel>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        userModel.signInWithEmailandPassword(mail, sifre);
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Email/Şifre Hatalı'),
            duration: Duration(seconds: 3)));
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => KullaniciBilgileri()));
    }
  }

  void _sifremiUnuttum(String mail) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    if (_formKey.currentState.validate()) {
      mail = _mailCont.text;
      userModel.sifremiUnuttum(mail);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Şifre Sıfırlama Maili Gönderildi'),
          duration: Duration(seconds: 3)));
    }
  }

  String isPasswordCompliant(String password, [int minLength = 6]) {
    if (password == null || password.isEmpty) {
      return 'Geçersiz Şifre';
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > minLength;
    if (hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength) return null;
  }
}
