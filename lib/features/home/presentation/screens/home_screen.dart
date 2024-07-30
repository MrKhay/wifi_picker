// ignore_for_file: public_member_api_docs

//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features.dart';
import 'available_tags_screen.dart';

///
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProductsScreenState();
}

///
class ProductsScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  int pageindex = 0;
  List<Widget> pages = <Widget>[
    const AvailableTagsScreen(),
    const SavedTagsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // init notifier
    ref.read(tagsNotifiierProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          selectedItemColor: context.colorScheme.surface,
          unselectedItemColor: context.colorScheme.primaryContainer,
          currentIndex: pageindex,
          onTap: (int index) {
            setState(() {
              pageindex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline_rounded), label: 'Saved'),
          ]),
      body: pages[pageindex],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
