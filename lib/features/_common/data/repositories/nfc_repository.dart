// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nfc_manager/nfc_manager.dart';

class NfcRepository {
  ///
  final NfcManager nfcManager;
  void Function(NfcTag tag) onDiscovered;
  void Function(String error) onError;

  ///
  NfcRepository({
    required this.nfcManager,
    required this.onDiscovered,
    required this.onError,
  });

  /// Returns true if supports nfc and false if not
  Future<bool> supportsNfc() async {
    return nfcManager.isAvailable();
  }

  Future<void> startSession() async {
    // Start Session
    await NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        onDiscovered.call(tag);
      },
      onError: (NfcError error) async {
        onError.call(error.message);
      },
    );
  }

  Future<void> stopSession() async {
    // Stop Session
    await nfcManager.stopSession();
  }
}
