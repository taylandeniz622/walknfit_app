import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walknfitapp/locator.dart';
import 'package:walknfitapp/screens/splash_intro/splash_screen.dart';
import 'package:walknfitapp/user_model/user_view_model.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
