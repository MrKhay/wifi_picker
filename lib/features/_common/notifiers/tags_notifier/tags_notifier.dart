import 'package:nfc_manager/nfc_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tags_notifier.g.dart';

@Riverpod(keepAlive: true)

///
class TagsNotifiier extends _$TagsNotifiier {
  @override
  Future<List<NfcTag>> build() async {
    return <NfcTag>[];
  }

  /// add tag
  void addTag(NfcTag tag) {
    final List<NfcTag> tags = state.value ?? <NfcTag>[];

    state = AsyncValue<List<NfcTag>>.data(<NfcTag>[tag, ...tags]);
  }
}