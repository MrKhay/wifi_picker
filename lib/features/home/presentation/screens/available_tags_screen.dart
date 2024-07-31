// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../../../_common/common.dart';
import '../../../features.dart';
import 'write_nfc.dart';

class AvailableTagsScreen extends ConsumerStatefulWidget {
  const AvailableTagsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvailableTagsState();
}

class _AvailableTagsState extends ConsumerState<AvailableTagsScreen> {
  late NfcRepository nfcRepository;
  late NfcManager nfcManager;
  // true when device supports nfc
  bool supportsNfc = true;

  @override
  void initState() {
    super.initState();
    nfcManager = NfcManager.instance;

    nfcRepository = NfcRepository(
      nfcManager: nfcManager,
      onDiscovered: onDiscovered,
      onError: onError,
    );

    startProcess();
  }

  void startProcess() {
    unawaited(nfcRepository.supportsNfc().then((bool value) {
      if (value) {
        nfcRepository.startSession();
      } else {
        if (mounted) {
          setState(() {
            supportsNfc = false;
          });
        }
      }
    }));
  }

  @override
  void dispose() {
    if (supportsNfc) {
      unawaited(nfcRepository.stopSession());
    }
    super.dispose();
  }

  void onDiscovered(NfcTag tag) {
    unawaited(HapticFeedback.mediumImpact());
    ref.read(tagsNotifiierProvider.notifier).addTag(tag);
  }

  void onError(String error) {
    context.showSnackBar(error, type: SnackBarType.error);
  }

  @override
  Widget build(BuildContext context) {
    final List<NfcTag> tags =
        ref.watch(tagsNotifiierProvider).value ?? <NfcTag>[];
    return Scaffold(
      appBar: appBar(
        context: context,
        // actions: <Widget>[
        //   IconButton(
        //       onPressed: () {
        //         ref.read(tagsNotifiierProvider.notifier).addTag(
        //             const NfcTag(handle: '345 Tag', data: <String, dynamic>{}));
        //       },
        //       icon: const Icon(Icons.add))
        // ],
        title: kAvaliableTags,
        centerTitle: true,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kGap_2),
        child: supportsNfc
            ? tags.isEmpty
                ? _searchingForTagWIg()
                : Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListView.separated(
                          itemCount: tags.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: kGap_2,
                          ),
                          padding: const EdgeInsets.all(kGap_2),
                          itemBuilder: (BuildContext context, int index) {
                            return _tagTile(tags[index]);
                          },
                        ),
                      )
                    ],
                  )
            : _doesNotSupportNfc(),
      ),
    );
  }

  Widget _tagTile(NfcTag tag) {
    final NavigatorState navigator = Navigator.of(context);
    return ListTile(
      enableFeedback: true,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(kGap_2),
          side: BorderSide(color: context.colorScheme.outline)),
      onTap: () {
        navigator.push(MaterialPageRoute(
          builder: (BuildContext context) => WriteNfc(
            tag: tag,
          ),
        ));
      },
      title: Text(
        tag.handle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.bodyLarge,
      ),
      trailing: Icon(
        Icons.wifi,
        color: context.colorScheme.primary,
      ),
    );
  }

  Widget _searchingForTagWIg() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(kGap_3),
            margin: const EdgeInsets.all(kGap_1),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.grey.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kGap_2),
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
                    Text(
                      'Wi-fi Picker',
                      style: context.textTheme.bodyLarge
                          ?.copyWith(letterSpacing: kGap_00),
                    ),
                  ],
                ),
                const SizedBox(height: kGap_3),
                Center(
                    child: Text(
                  'Currently searching for available Tag!',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(letterSpacing: kGap_00),
                )),
                const SizedBox(height: kGap_3),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SpinKitPulse(
                        duration: Durations.extralong4,
                        color: context.colorScheme.primary,
                        size: 400,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: ShapeDecoration(
                          color: context.colorScheme.primary,
                          shape: const CircleBorder(),
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
                const SizedBox(height: kGap_3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _doesNotSupportNfc() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kGap_3),
          margin: const EdgeInsets.all(kGap_2),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.grey.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kGap_2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Icon(
                Icons.error,
                size: kGap_4 + kGap_1,
                color: context.colorScheme.error,
              )),
              const SizedBox(height: kGap_3),
              Center(
                  child: Text(
                'Device does not support nfc!',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium
                    ?.copyWith(letterSpacing: kGap_01),
              )),
              const SizedBox(height: kGap_3),
            ],
          ),
        ),
      ],
    );
  }
}
