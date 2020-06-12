import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:walknfitapp/commons/button/button.dart';
import 'package:walknfitapp/screens/auth/kullanici_giris.dart';
import 'package:walknfitapp/user_model/user_view_model.dart';

class KullaniciKayit extends StatefulWidget {
  @override
  _KullaniciKayitState createState() => _KullaniciKayitState();
}

class _KullaniciKayitState extends State<KullaniciKayit> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  String mail;
  String sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Kayıt',
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
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Hata';
                        }
                      },
                      decoration: InputDecoration(
                        suffix: Icon(Icons.verified_user),
                        hintText: 'walknfit',
                        labelText: 'Kullanıcı Adı',
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
                      onSaved: (value) {
                        sifre = value;
                      },
                      decoration: InputDecoration(
                        suffix: Icon(Icons.lock_outline),
                        hintText: 'Şifre Giriniz',
                        labelText: 'Şifre',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) => isPasswordCompliant(value),
                      onSaved: (value) {
                        sifre = value;
                      },
                      decoration: InputDecoration(
                        suffix: Icon(Icons.lock_outline),
                        hintText: 'Tekrar Şifre Giriniz',
                        labelText: 'Şifre',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: FlatButton(
                          child: Text('KVKK ve Gizlilik sözleşmesi .......')),
                    ),
                    SizedBox(height: 20),
                    CommonButton(
                        text: Text('Kayıt'),
                        color: Colors.teal,
                        radius: 20,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            final userModel =
                                Provider.of<UserModel>(context, listen: false);
                            userModel.createUserWithEmailandPassword(
                                mail, sifre);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KullaniciGiris()));
                          }
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
