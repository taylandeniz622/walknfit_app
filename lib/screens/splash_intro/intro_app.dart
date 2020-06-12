import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:walknfitapp/screens/home.dart';
import 'package:walknfitapp/screens/auth/kullanici_giris.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AnaSayfa()));
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        'images/$assetName.png',
        width: 350,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      done: Text(('Başla')),
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: Text('Geç'),
      next: Icon(Icons.arrow_forward),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      key: introKey,
      pages: [
        PageViewModel(
          title: "Walk",
          body: "Attığın adımları takip et ve sürpriz hediyeler kazan.!",
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fit",
          body:
              "Sayısız besin arasından vücuduna yakışanı bul. En kolay ve hızlı şekilde forma gir !",
          image: _buildImage('img2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "İki uygulama tek çatıda !",
          body:
              "Hızlı geçiş yapabilir, iki uygulamaya istediğin zaman ulaşabilirsin.!",
          image: _buildImage('img3'),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
