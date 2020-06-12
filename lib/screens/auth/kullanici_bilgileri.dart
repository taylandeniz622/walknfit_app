import 'package:flutter/material.dart';

class KullaniciBilgileri extends StatefulWidget {
  @override
  _KullaniciBilgileriState createState() => _KullaniciBilgileriState();
}

class _KullaniciBilgileriState extends State<KullaniciBilgileri> {
  int stepindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stepper(
            onStepCancel: () {
              if (stepindex > 0) {
                setState(() {
                  stepindex--;
                });
              }
            },
            onStepContinue: () {
              if (stepindex < 4)
                setState(() {
                  stepindex++;
                });
            },
            currentStep: stepindex,
            steps: [
              Step(content: Text('Yaş'), title: Text('Yaşınız')),
              Step(content: Text('Boyunuz'), title: Text('Boy')),
              Step(content: Text('Kilonuz'), title: Text('Kilo')),
              Step(
                  content: Text('Cinsiyet'),
                  title: Text('Cinsiyet'),
                  isActive: false),
            ],
          ),
        ),
      ),
    );
  }
}
