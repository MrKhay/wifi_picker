// ignore_for_file: file_names, must_be_immutable, public_member_api_docs

import 'package:flutter/material.dart';

import '../../../_common/extensions/extensions.dart';
import 'text_font.dart';

class Button extends StatelessWidget {
  double width;
  double height;
  Button({
    required this.width,
    required this.height,
    super.key,
    this.onTap,
    required this.text,
  });
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        width: width,
        child: Center(
          child: Text(text,
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: context.colorScheme.surface)),
        ),
      ),
    );
  }
}
