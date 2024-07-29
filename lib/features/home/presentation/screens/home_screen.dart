import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.7,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFF2F2F2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/svgs/wifi_signal.svg',
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Wi-fi Picker',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Center(
                    child: Text(
                  'Currently searching for available Tag!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const SizedBox(height: 30),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      const SpinKitPulse(
                        duration: Durations.extralong4,
                        color: Color(0xFF5DB075),
                        size: 400,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: const ShapeDecoration(
                          color: Color(0xFF5DB075),
                          shape: CircleBorder(),
                        ),
                        child: SvgPicture.asset(
                          'assets/svgs/search_wifi.svg',
                          width: 46,
                          height: 55,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
