// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';
import '../widgets/text_font.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 80, 15, 0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WIFI PICKER',
              style: textfont(20, FontWeight.bold, Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 100,
              child: Image.asset(
                'images/wifi.PNG',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
                maxLines: 4,
                style: textfont(15, FontWeight.normal, Colors.black),
                'Simplifying the process of sharing Wifi passwords by using NFC tags.Users can tap their devices on an NFC tag to automatically connect to a Wifi network without manually entering the password.'),
            const SizedBox(
              height: 250,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Button(width: 200, height: 50, text: 'Get Started'))
          ],
        ),
      )),
    );
  }
}
