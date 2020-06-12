import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class VeriGirisi extends StatefulWidget {
  VeriGirisi({
    Key key,
  }) : super(key: key);

  @override
  _VeriGirisiState createState() => _VeriGirisiState();
}

class _VeriGirisiState extends State<VeriGirisi> {
  File _foodPhoto;
  ImagePicker _picker = ImagePicker();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
   
    super.initState();
  
  }

  Future _galeridenResimSec() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _foodPhoto = File(pickedFile.path);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey,
                    ),
                    child: _foodPhoto == null
                        ? Placeholder()
                        : Image.file(
                            _foodPhoto,
                          )),
                Positioned(
                  right: 20,
                  bottom: 10,
                  child: FlatButton(
                    child: Text(
                      'Resim Ekle',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 150,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text('Galeriden'),
                                    onTap: () {
                                      _galeridenResimSec();
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Besin Adı',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Açıklama',
                          hintMaxLines: 6,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      FlatButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(),
                        child: Text(
                          'Veri Tabanına Kaydet',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _formKey.currentState.save();
                          
                        },
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}
