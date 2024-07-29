// ignore_for_file: public_member_api_docs

//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../features.dart';
import 'mainscreen.dart';

///
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProductsScreenState();
}

///
class ProductsScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: kAppName,
        elevation: 0,
        backgroundColor: context.colorScheme.surface,
        style: GoogleFonts.redressed(
          textStyle: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colorScheme.primary,
          ),
        ),
      ),
      backgroundColor: context.colorScheme.surface,
      body: const Mainscreen(),
    );
  }
}
