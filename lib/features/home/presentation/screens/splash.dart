import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  _navigateToHome() async {
    if (mounted) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Lottie.asset(
              'assets/splash.json',
              fit: BoxFit.cover,
              repeat: false,
              onLoaded: (LottieComposition composition) {
                Future.delayed(composition.duration + Duration(seconds: 3),
                    _navigateToHome);
              },
            ),
          ),
        ],
      ),
    );
  }
}
