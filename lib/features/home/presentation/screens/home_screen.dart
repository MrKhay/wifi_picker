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
class ProductsScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // init notifier
    ref.read(tagsNotifiierProvider);

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: const AvailableTagsScreen(),
    );
  }
}
