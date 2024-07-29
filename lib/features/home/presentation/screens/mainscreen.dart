// ignore_for_file: public_member_api_docs, always_specify_types

import 'package:flutter/material.dart';
import 'available_tags.dart';
import 'write_nfc.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<Widget> pages = const <Widget>[AvailableTag(), Writenfc()];
  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(153, 230, 181, 181),
          currentIndex: pageindex,
          onTap: (index) {
            setState(() {
              pageindex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Save'),
          ]),
      body: pages[pageindex],
    );
  }
}
