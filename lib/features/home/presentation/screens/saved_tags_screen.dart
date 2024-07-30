import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';
import 'write_nfc.dart';

///
class SavedTagsScreen extends ConsumerStatefulWidget {
  ///
  const SavedTagsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SavedTagsScreenState();
}

class _SavedTagsScreenState extends ConsumerState<SavedTagsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: kSavedTags,
        centerTitle: true,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kGap_2),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _tagTile(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tagTile() {
    final NavigatorState navigator = Navigator.of(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kGap_2, vertical: kGap_2),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outline),
            borderRadius: BorderRadius.circular(kGap_1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'HNG Workplace',
              style: context.textTheme.bodyLarge,
            ),
            Icon(
              Icons.more_vert_sharp,
              color: context.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
